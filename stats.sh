#!/bin/sh

# get the log files
mkdir -p logs
cd logs

# check the config for a list of conditions to include
# '[{"dateFragment":"2020-10"},{"dateFragment":"2020-11"}]'

for row in $(echo "$FILTER" | jq -r '.[] | @base64'); do
   _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
   }
   datefrag=$(_jq '.dateFragment')
   echo "syncing for date fragment: $datefrag"
   aws s3 cp --exclude "*" --include "*$datefrag*" s3://$LOG_BUCKET/$LOG_PREFIX . --recursive
done

# go back to the home directory
cd ..

# build report
zcat logs/*.gz | webalizer -n $HOSTNAME -F w3c -o /var/www/html/ -

# run the command
exec "$@"
