#!/bin/bash

rsync -av \
    --delete \
    --exclude="/config/puma.rb" \
    --exclude="/config/database.yml" \
    --exclude="/config/master.key" \
    --exclude="/config/credentials.yml.enc" \
    --exclude="/config/application.yml" \
    --exclude="/log" \
    --exclude="/tmp" \
    --exclude="/node_modules" \
    --exclude="/public/assets" \
    --exclude="/public/packs" \
    --exclude="/storage" \
    --exclude="/deploy.sh" \
    --exclude="/.bundle" \
    /home/colors/Documents/web/trades/ \
    rails@159.89.126.253:/home/rails/trades