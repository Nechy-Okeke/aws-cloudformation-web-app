Simple Web App with CloudFormation
This repository contains a simple web application deployed on AWS using CloudFormation, with a CloudWatch dashboard for monitoring. The entire infrastructure is defined as code, allowing for automated and repeatable deployments.

Project Structure
aws-cloudformation/: Contains the CloudFormation template (web-app-with-cloudwatch.yaml) that defines all the AWS resources.

.github/workflows/: Contains the GitHub Actions workflow (deploy.yaml) for continuous deployment.

Getting Started
Prerequisites
An AWS account

The AWS CLI installed and configured

A GitHub account and a new repository for this project

Deployment
This project uses GitHub Actions for continuous deployment. The following steps will set up an automated pipeline that deploys your infrastructure whenever you push changes to the main branch.

Clone the Repository:

git clone [https://github.com/your-username/your-repository-name.git](https://github.com/your-username/your-repository-name.git)
cd your-repository-name

Add Your Files:
Place the web-app-with-cloudwatch.yaml file in the aws-cloudformation folder and the deploy.yaml file in the .github/workflows folder.

Configure AWS Credentials as GitHub Secrets:

In your GitHub repository, go to Settings > Secrets and variables > Actions.

Click "New repository secret".

Create a secret named AWS_ACCESS_KEY_ID with your AWS access key ID.

Create a second secret named AWS_SECRET_ACCESS_KEY with your AWS secret access key.

Push to GitHub:

git add .
git commit -m "Initial commit of CloudFormation template and CI/CD workflow"
git push origin main

This will automatically trigger the GitHub Actions workflow, which will deploy the CloudFormation stack to your AWS account.

Monitoring
Once the stack is deployed, you can monitor the application using the CloudWatch Dashboard created by the template. The dashboard URL can be found in the outputs of the CloudFormation stack in the AWS console.

This project was created to demonstrate a basic CI/CD pipeline for AWS CloudFormation. Feel free to modify and adapt it for your own needs.
9/13/2025