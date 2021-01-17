<p align="center">  
<a href="https://hub.docker.com/r/alishaikh/aws-ebcli"><img alt="Docker Cloud Build Status" src="https://img.shields.io/docker/cloud/build/alishaikh/aws-ebcli?style=flat-square">
</a>
<a href="https://hub.docker.com/r/alishaikh/aws-ebcli"><img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/alishaikh/aws-ebcli?style=flat-square"></a>
<a href="https://hub.docker.com/r/alishaikh/aws-ebcli"><img alt="Docker Image Size (latest by date)" src="https://img.shields.io/docker/image-size/alishaikh/aws-ebcli?style=flat-square">
</a>
<a href="https://hub.docker.com/r/alishaikh/aws-ebcli"><img alt="Docker Cloud Automated build" src="https://img.shields.io/docker/cloud/automated/alishaikh/aws-ebcli?style=flat-square"></a>
  <a href="https://hub.docker.com/r/alishaikh/aws-ebcli"><img alt="Docker Image Version (latest by date)" src="https://img.shields.io/docker/v/alishaikh/aws-ebcli?style=flat-square"></a>
</p>

## Docker Container with AWS CLI and AWS Elatic Beanstalk (EB) CLI
A container for running:
- AWS CLI
- AWS EB CLI
- Pyhton 3
- pip
- Git

Use it to deploy your applications from CLI or use the image in your CI/CD pipelines.

### Docker Pull Command
```docker pull alishaikh/aws-ebcli```

## Running - In a CLI

To run the CLI tools, use the CLI command just like you normally would. The combination of -w and -v mounts your PWD into the container as the current working directory for the EB CLI. If you're on Windows you'll want to use *%cd%* instead of *$PWD*.

	docker run -i -w /work -v $PWD:/work alishaikh/aws-ebcli eb --version
	docker run -i alishaikh/aws-ebcli aws --version
	docker run -i -w /work -v $PWD:/work alishaikh/aws-ebcli eb create test-app-${BUILD_NUMBER}
	docker run -i alishaikh/aws-ebcli aws ec2 describe-instances --region=us-east-1

To provide credentials, you have 2 options:

1. Use -e to export all your AWS creds env vars
2. Mount your ~/.aws directory to the docker container

### Example with -e

	docker run -i -w /work -v $PWD:/work -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN alishaikh/aws-ebcli eb status
	docker run -i -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN alishaikh/aws-ebcli aws ec2 describe-instances --region=us-east-1

### Example with mounting ~/.aws

#### PowerShell

`docker run -i -w /work -v ${PWD}:/work -v $env:USERPROFILE/.aws:/root/.aws alishaikh/aws-ebcli eb status`

#### Command Promt (CMD)

`docker run -i -w /work -v %cd%:/work -v %userprofile%/.aws:/root/.aws alishaikh/aws-ebcli eb status`

#### Linux

`docker run -i -w /work -v $PWD:/work -v ~/.aws:/root/.aws alishaikh/aws-ebcli eb status`
