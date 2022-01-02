temp_id="lt-0803b1e328525c4de"
aws ec2 describe-instances --filters "Name=tag:Name,Values=frontend"|jq .Reservations[].Instances[].State.Name | sed 's/"//g'|grep -E 'running|stopped' &>>/dev/null
if [ $? -eq 0 ]; then
  echo "Instance is already there"
  exit
fi

aws ec2 run-instances --launch-template LaunchTemplateId=${temp_id},Version=2 --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" "ResourceType=instance,Tags=[{Key=Name,Value=frontend}]"|jq