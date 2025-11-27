#!/bin/bash

song_info=$(playerctl --player=Feishin metadata --format '󰓇   {{title}}')

echo "$song_info"
