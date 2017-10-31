S3BUCKET="thisweek.today"

all: clean cfn site

cfn:
	# Deploy stack
	aws cloudformation package \
	   --template-file deploy.yml \
	   --output-template-file serverless-output.yaml \
	   --s3-bucket func-pkg/sam/
	aws cloudformation deploy \
   --template-file serverless-output.yaml \
	 --stack-name thisweektoday \
   --capabilities CAPABILITY_IAM \
	 --parameter-overrides \
	 		S3BucketName=$(S3BUCKET)

site:
	# Deploy site
	aws s3 cp --recursive thisweektoday s3://$(S3BUCKET)

clean:
	# clean local env
	rm -rf serverless-output.yaml *.ics
