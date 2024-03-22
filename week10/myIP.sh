#! /bin/bash

ip addr | grep -m2 "inet " | tail -n1 | grep -o -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | head -n1
