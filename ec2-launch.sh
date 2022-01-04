COMPONENT=$1
ENV=$2
if [ ! -z "$ENV" ]; then
  ENV="-${ENV}"
fi
if [ -z "${COMPONENT}" ]; then
  echo "input missing"
  exit
fi
temp_id="lt-0803b1e328525c4de"
ZONE_ID="Z09972541YT3UVO8YWPEG"
CREATE_INSTANCE()
{
  aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].State.Name | sed 's/"//g'|grep -E 'running|stopped' &>>/dev/null
  if [ $? -eq 0 ]; then
    echo "Instance is already there"
  else
    aws ec2 run-instances --launch-template LaunchTemplateId=${temp_id},Version=2 --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${COMPONENT}}]" "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"|jq
  fi
  sleep 10
  IPADDRESS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].PrivateIpAddress | sed 's/"//g' | grep -v null)
  sed -e "s/IPADDRESS/${IPADDRESS}/" -e "s/COMPONENT/${COMPONENT}/" record.json >/tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch file:///tmp/record.json | jq
}
COMPONENT=$COMPONENT$ENV
  CREATE_INSTANCE
