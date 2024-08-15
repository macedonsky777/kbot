pipeline {
    agent any
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm64'], description: 'Pick Architecture')
    }
    stages {
        stage('Build') {
            steps {
                script {
                    def targetOS = ''
                    def targetArch = ''

                    if (params.OS == 'linux') {
                        targetOS = 'linux'
                    } else if (params.OS == 'darwin') {
                        targetOS = 'darwin'
                    } else if (params.OS == 'windows') {
                        targetOS = 'windows'
                    }

                    targetArch = params.ARCH

                    echo "Building for OS: ${targetOS}, Architecture: ${targetArch}"
                    sh "make TARGETOS=${targetOS} TARGETARCH=${targetArch} build"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def targetOS = ''
                    def targetArch = ''

                    if (params.OS == 'linux') {
                        targetOS = 'linux'
                    } else if (params.OS == 'darwin') {
                        targetOS = 'darwin'
                    } else if (params.OS == 'windows') {
                        targetOS = 'windows'
                    }

                    targetArch = params.ARCH

                    echo "Building Docker image for OS: ${targetOS}, Architecture: ${targetArch}"
                    sh "make TARGETOS=${targetOS} TARGETARCH=${targetArch} image"
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    def targetOS = ''
                    def targetArch = ''

                    if (params.OS == 'linux') {
                        targetOS = 'linux'
                    } else if (params.OS == 'darwin') {
                        targetOS = 'darwin'
                    } else if (params.OS == 'windows') {
                        targetOS = 'windows'
                    }

                    targetArch = params.ARCH

                    echo "Pushing Docker image for OS: ${targetOS}, Architecture: ${targetArch}"
                    sh "make TARGETOS=${targetOS} TARGETARCH=${targetArch} push"
                }
            }
        }
    }
}

