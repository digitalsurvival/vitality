#!/bin/bash

# This command depends upon app-portage/eix
NAMEVERSION="<category>/<name>-<version>" eix -I --format 'Package: <installedversions:NAMEVERSION>,License: <licenses>,Homepage: <homepage>\n' >> `date +\%Y.\%m.\%d`.csv
