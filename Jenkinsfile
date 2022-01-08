pipeline {
agent { label 'WORKSTATION' }
options {
        ansiColor('xterm')
    }
    stages
    {
        stage('One')
        {
            steps
            {
                sh 'ansible-playbook 08-parallel-plays.yml'
            }
        }
    }
}