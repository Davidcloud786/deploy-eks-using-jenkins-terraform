pipeline {
  agent any

  environment {
    AWS_ACCOUNT_ID     = "209479282892"
    AWS_DEFAULT_REGION = "us-east-1"
  }

  stages {

    stage('Terraform Init') {
      environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
      }
      steps {
        sh '''
          # FORCE Jenkins to drop old cached providers
          rm -rf .terraform
          rm -f .terraform.lock.hcl

          # Re-download providers (AWS v6, Kubernetes v3)
          terraform init -upgrade -reconfigure

          # PROOF: show provider versions being used
          terraform providers
        '''
      }
    }

    stage('Terraform Destroy') {
      environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
      }
      steps {
        sh '''
          terraform destroy -auto-approve
        '''
      }
    }
  }
}
