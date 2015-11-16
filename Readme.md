# Docker Nginx Proxy

Purpose: Provide automatic dns for local container development

see https://github.com/jwilder/nginx-proxy for more info

## Getting Started

1. Clone Repo
2. run `./setup.sh && docker-compose up -d`

## Setup.sh

Run this file to configure a local .dev dns zone to route to your local docker-machine
all requests to *.dev will route through the nginx-proxy container exposed on $(docker-machine ip default):80

## Dependencies

local docker-machine installation 