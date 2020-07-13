#!/bin/bash
cat /tmp/datacenter.txt

cd $( puppet agent --configprint statedir )
cat .\resources.txt