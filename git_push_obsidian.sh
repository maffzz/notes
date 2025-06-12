#!/bin/bash
cd /Users/maferlazon/Documents/notes
git add .
git commit -m "backup: $(date '+%Y-%m-%d %H:%M:%S')"
git push
