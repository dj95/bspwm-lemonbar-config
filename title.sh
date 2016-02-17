#!/bin/bash

xtitle -s | while read line; do
    output=""
    
    for desktop in $( bspc query -D ); do
        ACTIVE_WS=false
        
        for line in "$( bspc query -T -d ${desktop} )"; do
            if [[ "${line}" =~ ^(.*)0\,0\,0\,0\ M\ \-\ \*(.*)$ ]]; then # monocle mode
                active=$( echo "${line}" | grep -oP '\w\ ([a-zA-Z]*)\ ([a-zA-Z]*)\ (0x[0-9A-F]*)\ (.*)\-\ \*' | grep -oP '0x[0-9A-F]{7}')
                
                # get titles
                for win in $( bspc query -W -d ${desktop} ); do
                    if [[ "$win" == "$active" ]]; then
                        output=$output"%{F#000000}%{B#905D5D5D}%{T3}◤%{T-}%{F#BDBDBD} "$( xtitle $win | head -c 40 )" %{F#905D5D5D}%{B#000000}%{T3}◤%{T-}"
                    else
                        output=$output"%{F#000000}%{B#000000}%{T3}◤%{T-}%{F#BDBDBD} "$( xtitle $win | head -c 40 )" %{F#000000}%{B#000000}%{T3}◤%{T-}"
                    fi
                done
            elif [[ "${line}" =~ ^(.*)0\,0\,0\,0\ T\ \-\ \*(.*)$ ]]; then
                active=$( echo "${line}" | grep -oP '\w\ ([a-zA-Z]*)\ ([a-zA-Z]*)\ (0x[0-9A-F]*)\ (.*)\-\ \*' | grep -oP '0x[0-9A-F]{7}')
                output="$( xtitle $active | head -c 40 )%{F#000000}%{B#000000}%{T3}◤%{T-} "
            fi
        done
    done

    echo "T$output"
done
