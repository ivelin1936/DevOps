#!/bin/bash

terraform graph | dot -Tpng -o main.png
