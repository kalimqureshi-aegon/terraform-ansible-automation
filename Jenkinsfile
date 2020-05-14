pipeline {
    agent {
        label 'Kubernetes'
    }
    environment {
		EMAIL_TO = 'kalim.qureshi@aegonlife.com'
        PLANONLYINVENTORY = "$WORKSPACE/Inventories/dt/inventory-apply-existing-plan"
        EXECUTEINVENTORY = "$WORKSPACE/Inventories/dt/inventory-create-exec-plan"
    }
    parameters {
		choice (choices: ['ApplyExistingPlan', 'ExecuteTerraform'], description: 'Choose type of deployment for Terraform Scripts', name: 'DeploymentType')
	}
    stages {
        stage('Checkout Devops') {
            steps {
                script{
                        def scmVar = checkout([$class: 'GitSCM', \
                            branches: [[name: '*/master']], \
                            userRemoteConfigs: [[credentialsId: 'd687052d-a063-406b-8e26-f90f4397ea49',
                                            url: "https://github.com/blitzkalim/terraform-ansible-automation.git"]]])
                }
            }
        }
        stage('Deploy Ansible Playbook') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-Dev']]) {                       
                        script{
                            if (params.DeploymentType =="ApplyExistingPlan"){
                                print 'INFO: Plan only tasks will be executed'
                                sh "ansible-playbook -i $PLANONLYINVENTORY main.yml"
                            }
                            else{
                                print 'INFO: Execute Terraform project tasks will be executed : ' + params.DeploymentType
                                sh "ansible-playbook -i $EXECUTEINVENTORY main.yml"
                            }
                        }
                }
            }
        }
    }
	post {
        success {
			script {
				def mailRecipients = 'EMAIL_TO'
                def jobName = currentBuild.fullDisplayName
                    emailext body: '''${SCRIPT, template="groovy-html.template"}''',
                    mimeType: 'text/html',
                    subject: "[Jenkins] ${jobName}",
                    to: "$EMAIL_TO",
                    replyTo: "$EMAIL_TO",
                    recipientProviders: [[$class: 'CulpritsRecipientProvider']]
			}
		}
		failure {
			script {
				def mailRecipients = 'EMAIL_TO'
                def jobName = currentBuild.fullDisplayName
                    emailext body: '''${SCRIPT, template="groovy-html.template"}''',
                    mimeType: 'text/html',
                    subject: "[Jenkins] ${jobName}",
                    to: "$EMAIL_TO",
                    replyTo: "$EMAIL_TO",
                    recipientProviders: [[$class: 'CulpritsRecipientProvider']]
			}
		}
	}
}