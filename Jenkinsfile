node('jenkins_micro_aws_slave') {
  environment{
      registry = "juliashub/foaas"
      registryCredential = "dockerhub-julia"
      credentialsId = "secret-github"
  }
  def DockerImage = "foaas:v1.0"
  def customImage = null
  stage('Git') { // Get code from GitLab repository
    git branch: 'master',
      url: 'https://github.com/Juliavol/opsschool-midterm-app.git'
  }

  stage('Build') { // Run the docker build
    customImage = docker.build "juliashub/foaas:${env.BUILD_NUMBER}"

  }
  stage('Run Tests') {
    sh "docker run --rm ${customImage.id} test"
  }
  stage('Push to Docker Hub') { // Run the built image
    withDockerRegistry(credentialsId: 'dockerhub-julia') {
        customImage.push()
    }
  }
  stage('Deploy to K8s') { // Run tests on container
    kubernetesDeploy(configs: 'k8s/*', kubeconfigId: 'kube-config', textCredentials: [serverUrl: 'https://'])
  }
}