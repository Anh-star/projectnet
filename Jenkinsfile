pipeline {
    agent any

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

        stage('Publish to folder') {
            steps {
                echo 'Publishing to folder...'
                bat 'dotnet publish -c Release -o ./publish'
            }
        }

        stage('Copy to IIS folder') {
            steps {
                echo 'Copying to IIS folder...'
                // iisreset /stop // stop iis de ghi de file
                bat 'xcopy "%WORKSPACE%\\publish" /E /Y /I /R "c:\\wwwroot\\myproject"'
            }
        }

        stage('Deploy to IIS') {
            steps {
                powershell '''
                # Tạo website nếu chưa có
                Import-Module WebAdministration
                if (-not (Test-Path IIS:\\Sites\\MySite)) {
                    New-Website -Name "MySite" -Port 81 -PhysicalPath "c:\\test1-netcore"
                }
                '''
            }
        }
    }
}
