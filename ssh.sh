#!/bin/bash

ssh-keygen -t rsa
chmod 0600 ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
