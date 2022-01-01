temp_id="lt-0803b1e328525c4de"
version=2
aws ec2 --launch-template LaunchTemplateId=${temp_id},Version=${version}  --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" "ResourceType=instance,Tags=[{Key=Name,Value=frontend}]"|jq