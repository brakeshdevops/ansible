pipeline {
agent { label 'WORKSTATION' }
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