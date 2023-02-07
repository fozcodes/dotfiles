function assume-aws-role 
  set creds (aws sts assume-role --role-arn $ROLE_ARN  --role-session-name foz-assumed-role)
  set aws_key_id (echo "$creds" | jq '.Credentials.AccessKeyId')
  set aws_secret_key (echo "$creds" | jq '.Credentials.SecretAccessKey')
  set aws_session_token (echo "$creds" | jq '.Credentials.SessionToken')

  echo $aws_key_id
  echo $aws_secret_key
  echo $aws_session_token

  set -Ux AWS_ACCESS_KEY_ID $aws_key_id
  set -Ux AWS_SECRET_ACCESS_KEY $aws_secret_key
  set -Ux AWS_SESSION_TOKEN $aws_session_token
end

function unset-aws-creds
  set -e AWS_ACCESS_KEY_ID
  set -e AWS_SECRET_ACCESS_KEY
  set -e AWS_SESSION_TOKEN 
end
