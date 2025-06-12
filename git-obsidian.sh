#!/bin/bash
cd "/Users/maferlazon/Documents/notes"

git add .
git commit -m "auto backup: $(date)"
git push
