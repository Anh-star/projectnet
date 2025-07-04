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
        bat 'dotnet publish ./projectnet/projectnet.csproj -c Release -o ./publish'
    }
}

stage('Copy to IIS folder') {
    steps {
        echo 'Copying to IIS folder...'
        bat 'xcopy "%WORKSPACE%\\publish" /E /Y /I /R "C:\\wwwroot\\myproject"'
    }
}

        stage('Deploy to IIS') {
            steps {
                powershell '''
                    $targetPath = "C:\\wwwroot\\myproject"

                    # Tạo thư mục nếu chưa tồn tại
                    if (-Not (Test-Path $targetPath)) {
                        New-Item -Path $targetPath -ItemType Directory -Force
                    }

                    # Yêu cầu quyền Admin để truy cập IIS
                    Import-Module WebAdministration

                    # Tạo website nếu chưa có
                    if (-not (Test-Path IIS:\\Sites\\MySite)) {
                        New-Website -Name "MySite" -Port 81 -PhysicalPath $targetPath
                    }
                '''
            }
        }
    }
}
