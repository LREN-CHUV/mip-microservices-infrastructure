#!/bin/bash

mkdir out

ansible-inventory-grapher -i etc/ansible/hosts demo --format "out/inventory.dot" \
  -a "rankdir=RL; ranksep=2;\
      node [ width=5 style=filled fillcolor=lightgrey ];\
      edge [ dir=back arrowtail=empty ];"
dot -Tpng -o inventory-config.png out/inventory.dot

rm -rf out
