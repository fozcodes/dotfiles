function add-aws-assumed-role-to-env --argument sts_output \
  --description "The output of a successful call to `aws sts assume-role`"

  set access_key (cat $sts_output)
  echo $access_key
end
