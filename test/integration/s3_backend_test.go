package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
	awsTerratest "github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAwsS3BackendBucket(t *testing.T) {
	/* ARRANGE */
	t.Parallel()
	// Give this S3 Bucket a unique ID for a name tag so we can distinguish it from any other Buckets provisioned
	// Globally
	expectedBucketName := fmt.Sprintf("terratest-backend-bucket-test-%s", strings.ToLower(random.UniqueId()))
	// AWS region set in provider.tf or versions.tf
	expectedAwsRegion := "eu-west-2"
	expectedVersioningStatus := "Enabled"
	expectBucketPublicBlock := "{\n  PublicAccessBlockConfiguration: {\n    BlockPublicAcls: true,\n    BlockPublicPolicy: true,\n    IgnorePublicAcls: true,\n    RestrictPublicBuckets: true\n  }\n}"

	expectedTags := map[string]interface{}{
		"Owner":       "Abhishek Rajput",
		"Team":        "Terratest",
		"Environment": "Dev",
		"Description": "Resources for s3 backend",
		"Repository":  "https://github.com/abhisheksr01/terraform-modules",
		"Provisioner": "Terraform",
	}
	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		// s3-backend/test/integration/s3_backend_test.go
		TerraformDir: "../../example",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"bucket_name":         expectedBucketName,
			"dynamodb_table_name": expectedBucketName,
			"default_tags":        expectedTags,
		},
	})

	/* ACTION */
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)
	// This will run `terraform init` and `terraform plan` and fail the test if there are any errors
	terraform.InitAndPlan(t, terraformOptions)
	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	/* ASSERTING S3 BUCKET */
	// Run `terraform output` to get the value of an output variable
	bucketID := terraform.Output(t, terraformOptions, "s3_backend_bucket_id")
	// Assert bucket have versioning enabled
	actualVersioningStatus := awsTerratest.GetS3BucketVersioning(t, expectedAwsRegion, bucketID)
	assert.Equal(t, expectedVersioningStatus, actualVersioningStatus)

	session, err := session.NewSession(&aws.Config{
		Region: &expectedAwsRegion},
	)
	// Create S3 service clienthttps://ca.slack-edge.com/T03BGDG7A-UMYTD01SM-56cb4c04c1b6-512
	svc := s3.New(session)
	//Assert bucket have ACL
	actualBucketACL, err := svc.GetBucketAcl(&s3.GetBucketAclInput{Bucket: aws.String(bucketID)})
	if err != nil {
		exitErrorf("Unable to GetBucketAclInput, %v", err)
	}
	assert.NotEmpty(t, actualBucketACL)

	//Assert bucket blocks all public access
	actualPublicAccessBlock, err := svc.GetPublicAccessBlock(&s3.GetPublicAccessBlockInput{Bucket: aws.String(bucketID)})
	assert.EqualValues(t, expectBucketPublicBlock, actualPublicAccessBlock.String())

	//Assert bucket have expected encryption
	actualEncryption, err := svc.GetBucketEncryption(&s3.GetBucketEncryptionInput{Bucket: aws.String(bucketID)})
	assert.EqualValues(t, "aws:kms", *actualEncryption.ServerSideEncryptionConfiguration.Rules[0].ApplyServerSideEncryptionByDefault.SSEAlgorithm)
	assert.EqualValues(t, true, *actualEncryption.ServerSideEncryptionConfiguration.Rules[0].BucketKeyEnabled)

	//Assert bucket have expected Ownership
	actualOwnership, err := svc.GetBucketOwnershipControls(&s3.GetBucketOwnershipControlsInput{Bucket: aws.String(bucketID)})
	assert.EqualValues(t, "BucketOwnerPreferred", *actualOwnership.OwnershipControls.Rules[0].ObjectOwnership)

	//Assert bucket have all the expected tags
	actualTag, err := svc.GetBucketTagging(&s3.GetBucketTaggingInput{Bucket: aws.String(bucketID)})
	for _, b := range actualTag.TagSet {
		assert.EqualValues(t, expectedTags[*b.Key], *b.Value)
	}

	/* ASSERTING DYNAMODB TABLE */
	dynamoDBID := terraform.Output(t, terraformOptions, "state_lock_dynamodb_table_id")
	// Assert bucket have versioning enabled
	dynamoDBObj := awsTerratest.GetDynamoDBTable(t, expectedAwsRegion, dynamoDBID)
	assert.Equal(t, "PAY_PER_REQUEST", *dynamoDBObj.BillingModeSummary.BillingMode)
	assert.Equal(t, "ENABLED", *dynamoDBObj.SSEDescription.Status)
	assert.Equal(t, "KMS", *dynamoDBObj.SSEDescription.SSEType)
	ddTags := awsTerratest.GetDynamoDbTableTags(t, expectedAwsRegion, dynamoDBID)
	for _, b := range ddTags {
		assert.EqualValues(t, expectedTags[*b.Key], *b.Value)
	}
}

func exitErrorf(msg string, args ...interface{}) {
	fmt.Fprintf(os.Stderr, msg+"\n", args...)
	os.Exit(1)
}
