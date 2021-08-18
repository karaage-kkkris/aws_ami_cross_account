echo "** terminating EC2 ${instance_id} in region ${region} **"

aws ec2 terminate-instances --region "${region}" --instance-ids "${instance_id}"
