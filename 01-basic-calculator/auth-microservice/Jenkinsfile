pipeline {
    agent none

    environment {
        IMAGE_NAME = 'thrijwaldockerboy/ecs-loginbasiccalc'
        CONTAINER_NAME = 'login-basiccalc-container'
        APP_PORT = '5100'
    }

    stages {
        stage('Checkout Code') {
            agent { label 'maven' }
            steps {
                checkout scm
                script {
                    echo "Checked out branch: ${env.BRANCH_NAME}"
                }
            }
        }

        stage('Build & Push Docker Image') {
            agent { label 'maven' }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo "Building Docker image..."
                    docker build -t ${IMAGE_NAME}:${env.BRANCH_NAME} .

                    echo "Logging into DockerHub..."
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                    echo "Pushing image to DockerHub..."
                    docker push ${IMAGE_NAME}:${env.BRANCH_NAME}

                    docker logout
                    """
                }
            }
        }

        stage('Deploy to Server') {
            when {
                allOf {
                    expression { env.BRANCH_NAME.startsWith('release_') }
                }
            }
            agent { label 'deployment_server' }

            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo "Logging into DockerHub..."
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                    echo "Pulling image ${IMAGE_NAME}:${env.BRANCH_NAME}..."
                    docker pull ${IMAGE_NAME}:${env.BRANCH_NAME}


                    echo "Running container..."
                    docker run -dit --name ${CONTAINER_NAME} \
                        -p ${APP_PORT}:5100 \
                        ${IMAGE_NAME}:${env.BRANCH_NAME}

                    docker logout
                    """
                }
            }
        }
    }

    post {
        success {
            echo " Pipeline completed successfully for branch: ${env.BRANCH_NAME}"
        }
        failure {
            echo " Pipeline failed for branch: ${env.BRANCH_NAME}"
        }
    }
}
