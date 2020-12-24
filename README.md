# cf-stats

![build and push to public aws ecr](https://github.com/richardjkendall/cf-stats/workflows/build%20and%20push%20to%20public%20aws%20ecr/badge.svg)

This builds a docker image which contains a small amount of code to orchestrate the creation of web access statistics for a CloudFront distribution using the Webalizer.

It reads the CloudFront logs from S3 and runs the Webalizer over them.

Available on ECR public here https://gallery.ecr.aws/z7f7v2i3/cf-stats

## Use

You can pull and use this image as follows.  Environment variable details are in the section below.

```bash
docker run \
  -e LOG_BUCKET \
  -e LOG_PREFIX \
  -e HOSTNAME \
  -e FILTER \
  -p 8080:80 \
  public.ecr.aws/z7f7v2i3/cf-stats:latest
```

## Environment variables

The following variables are needed:

| Variable | Description |
| ---      | ---         |
| LOG_BUCKET | The name of the S3 bucket which contains the logs |
| LOG_PREFIX | The 'prefix' or folder which contains the logs |
| HOSTNAME | The hostname of the site which is hosted in CloudFront |
| FILTER | JSON, a list of objects containing date fragments to use to filter the logs, see below for more details |

### Filter

The filter JSON should be formed as follows

```json
[
  {
    dateFragment: "2020-11"
  },
  {
    dateFragment: "2020-12"
  }
]
```

The date fragments can be years, years and months or years and months and day.