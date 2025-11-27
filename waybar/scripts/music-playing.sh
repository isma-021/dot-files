#song_info=$(playerctl metadata --format '{{title}} - {{artist}}' | sed 's/ - Topic//')
STATUS=$(playerctl status 2>/dev/null)
ARTISTS=$(playerctl --player=mpd metadata artist | sed 's/ - Topic//' 2>/dev/null)
TITLE=$(playerctl --player=mpd metadata title 2>/dev/null)

if [[ "$STATUS" == "Playing" ]]; then
    ICON=""  # Icono de play
elif [[ "$STATUS" == "Paused" || "$STATUS" == "Stopped" ]]; then
    ICON=""  # Icono de pausa/stop
else
    ICON=""  # Genérico si algo falla
fi

echo "$ICON  $TITLE - $ARTISTS"

#echo $song_info
