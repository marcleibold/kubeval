#!/bin/sh

while getopts ":d:" opt; do
  case $opt in
    d)
      CONTENT="$(/kubeval -d $OPTARG -o stdout --strict=true --kubernetes-version=master --openshift=false --ignore-missing-schemas=true)"
      CONTENT="${CONTENT//'%'/'%25'}"
      CONTENT="${CONTENT//$'\n'/'%0A'}"
      CONTENT="${CONTENT//$'\r'/'%0D'}"
      echo "::set-output name=all::$CONTENT"
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      CONTENT="$(/kubeval -d "." -o stdout --strict=true --kubernetes-version=master --openshift=false --ignore-missing-schemas=true)"
      CONTENT="${CONTENT//'%'/'%25'}"
      CONTENT="${CONTENT//$'\n'/'%0A'}"
      CONTENT="${CONTENT//$'\r'/'%0D'}"
      echo "::set-output name=all::$CONTENT"
      exit 1
      ;;
  esac
done