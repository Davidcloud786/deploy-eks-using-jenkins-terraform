pipeline {
  agent any

  environment {
    AWS_ACCOUNT_ID      = "209479282892"
    AWS_DEFAULT_REGION  = "us-east-1"
  }

  stages {

    stage('Terraform Init') {
      environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
      }
      steps {
        sh '''
          terraform init -reconfigure
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
