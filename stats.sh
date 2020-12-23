#!/bin/sh

# get the log files
mkdir logs
cd logs
# --exclude "*" --include "*2020-12*"
aws s3 sync --exclude "*" --include "*2020-11-0*" --include "*2020-11-1*" s3://$LOG_BUCKET/$LOG_PREFIX .
cd ..

# build report
zcat logs/*.gz | goaccess - --log-format=CLOUDFRONT -o index.html

# copy report
cp index.html /var/www/html
