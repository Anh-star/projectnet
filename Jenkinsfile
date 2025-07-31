pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "projectnet:latest"
        DOCKER_CONTAINER = "projectnet-container"
    }
    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/Anh-star/projectnet.git'
            }
        }

        stage('Restore packages') {
            steps {
                echo 'Restoring packages...'
                bat 'dotnet restore'
            }
        }

        stage('Build project') {
            steps {
                echo 'Building project...'
                bat 'dotnet build --configuration Release'
            }
        }

        stage('Run tests') {
            steps {
                echo 'Running tests...'
                bat 'dotnet test --no-build --verbosity normal'
            }
        }

        stage('Publish') {
            steps {
                echo 'Publishing project...'
                bat 'dotnet publish ./projectnet/projectnet.csproj -c Release -o ./publish'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t projectnet:latest -f Dockerfile .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                bat '''
                    docker stop %DOCKER_CONTAINER% || true
                    docker rm %DOCKER_CONTAINER% || true
                    docker run -d --name %DOCKER_CONTAINER% -p 81:80 %DOCKER_IMAGE%
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Deployment succeeded!'
        }
        failure {
            echo '❌ Build or deployment failed.'
        }
    }
}
