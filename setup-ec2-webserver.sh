#!/bin/bash

if [ "$#" -lt 4 ]; then
    echo "Usage: setup-ec2-webserver.sh -d <domain> -p <port>"
    echo "Example: setup-ec2-webserver.sh -d example.com -p 1337"
    echo "Parameters:"
    echo "    -d,--domain      Domain name for the server"
    echo "    -p,--port        Internal port to reverse proxy towards"
    exit 22
fi

# Initialize variables for storing option values
while getopts ":d:p:" opt; do
  case $opt in
    d)
      domain="$OPTARG"
      ;;
    p)
      port="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Parse long-form options using case statement
for arg in "$@"; do
  if [[ $arg == --* ]]; then
    key=$(echo $arg | cut -d= -f1 | tr -d --)
    value=$(echo $arg | cut -d= -f2-)

    case $key in
      domain)
        domain=$value
        ;;
      port)
        port=$value
        ;;
      *)
        echo "Invalid long-form option: $key" >&2
        exit 1
        ;;
    esac
  fi
done

sudo apt update
sudo apt upgrade
sudo apt install nginx certbot python3-certbot-nginx

sudo certbot --nginx -d $domain
sudo cp -v $HOME/dotfiles/nginx.conf /etc/nginx/conf.d/default.conf

sed -i "s|@DOMAIN@|$domain|" /etc/nginx/conf.d/default.conf
sed -i "s|@PORT@|$port|" /etc/nginx/conf.d/default.conf

sudo systemctl enable nginx --now
