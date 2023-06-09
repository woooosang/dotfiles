#!/usr/bin/env bash

sudo apt-get install nala
xargs sudo nala install < apt-packages.txt
