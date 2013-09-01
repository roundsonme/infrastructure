#!/usr/bin/python

import re
import json
import urllib
import os.path
import urllib2

from boto.s3.connection import S3Connection
from boto.s3.key import Key

phonegap = "https://build.phonegap.com/"
configuration = "~/.phonegap-build/config"

config = file(os.path.expanduser(configuration)).read()
build = re.search('build = "(.*)"', config).group(1)
secret = re.search('secret = "(.*)"', config).group(1)
download = re.search('download = "(.*)"', config).group(1)

build = build + "?" + urllib.urlencode({ "auth_token": secret })
response = json.loads(urllib2.urlopen(build).read())
current = response["download"]["android"]
download = download + current + "?" + urllib.urlencode({ "auth_token": secret })
data = urllib2.urlopen(download).read()

number = str(response["build_count"])
filename = "customer-" + number + ".apk"

s3 = S3Connection()
bucket = s3.get_bucket("roundsonme")
key = Key(bucket, filename)
key.set_contents_from_string(data)
key.set_metadata("Content-Type", "application/vnd.android.package-archive")
key.set_acl("public-read")

print key.generate_url(expires_in=0, query_auth=False)

key = Key(bucket, "latest.apk")
key.set_contents_from_string(data)
key.set_metadata("Content-Type", "application/vnd.android.package-archive")
key.set_acl("public-read")

print key.generate_url(expires_in=0, query_auth=False)
