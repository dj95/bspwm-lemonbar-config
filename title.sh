#!/bin/bash


bspc subscribe | while read line; do
    output=""
    focused_window_id=$( bspc query -N -n )
    if [[ -z $focused_window_id ]]; then
        output="%{F#000000}%{B#000000}%{T3}◤%{T-} "
    else
        if [[ $( bspc query -T -d | jshon -e layout ) = "\"tiled\"" ]]; then  
            output="$( xtitle $focused_window_id | head -c 40 )%{F#000000}%{B#000000}%{T3}◤%{T-} "
        else
            for win in $( bspc query -N -d ); do
                title=$( xtitle $win | head -c 40 )
                if [[ $title != "" ]]; then
                    if [[ $win = $focused_window_id ]]; then
                        output=$output"%{F#000000}%{B#905D5D5D}%{T3}◤%{T-}%{F#BDBDBD} "$( xtitle $win | head -c 40 )" %{F#905D5D5D}%{B#000000}%{T3}◤%{T-}"
                    else
                        output=$output"%{F#000000}%{B#000000}%{T3}◤%{T-}%{F#BDBDBD} "$( xtitle $win | head -c 40 )" %{F#000000}%{B#000000}%{T3}◤%{T-}"
                    fi
                fi
            done
        fi
    fi
    echo "T$output"
done
