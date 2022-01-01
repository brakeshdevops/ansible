temp_id="lt-0803b1e328525c4de"
version=2
aws ec2 --launch-template LaunchTemplateId=${temp_id} Version=${version}|jq