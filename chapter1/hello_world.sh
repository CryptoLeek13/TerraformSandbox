#!/bin/bash
echo "Hello, Malik" > index.html
nohup busybox httpd -f -p 8080 &
