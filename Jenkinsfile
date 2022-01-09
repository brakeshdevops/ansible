pipeline {
agent { label 'WORKSTATION' }
options {
        ansiColor('xterm')
    }
parameters
{
    choice(name:'ENV', choices: ['DEV','PROD'], description:'Choose Env')
    string(name:'COMPONENT',defaultValue:'',description:'Which app component' )
}
environment
{
SSh=credentials('centos')
}
    stages
    {
        stage('Create Server')
        {
            steps
            {
                sh 'bash ec2-launch.sh ${COMPONENT} ${ENV}'
            }
        }
        stage('Ansible play book run')
        {
            steps
            {
                script
                {
                    env.ANSIBLE_TAG=COMPONENT.toUpperCase()
                }
                sh 'sleep 60'
                sh 'ansible-playbook -i roboshop.inv roboshop.yml -e ENV=${ENV} -t ${ANSIBLE_TAG} -e ansible_password=${SSH_PSW} -u ${SSh_USR}'
            }
        }
    }
}