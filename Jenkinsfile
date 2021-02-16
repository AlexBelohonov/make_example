pipeline {
    agent any

    environment {
        PATH="/var/lib/jenkins/miniconda3/bin:$PATH"
    }

    stages {
        stage('Run linter') {
            steps {
                sh '''
                    conda create --yes -n app_env python
                    source activate app_env
                    pip install -r requirements.txt
                    make pylint
                '''
            }
        }
        stage('Run tests') {
            steps {
                sh '''
                    make test
                '''
            }
        }
    }
    post {
        always {
            sh 'conda remove --yes -n app_env --all'
        }
    }
}