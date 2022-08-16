#!/bin/sh

while getopts ":d:" opt; do
  case $opt in
    d)
      echo "::set-output all=$(/kubeval -d $OPTARG -o stdout --strict true --kubernetes-version master --openshift false --ignore-missing-schemas true)"
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "::set-output all=$(/kubeval -d $OPTARG -o stdout --strict true --kubernetes-version master --openshift false --ignore-missing-schemas true)"
      exit 1
      ;;
  esac
done