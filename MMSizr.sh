#!/bin/sh

MAXsize=1900000;
for v in `find $1/*.jpeg $1/*.jpg $1/*.gif $1/*.png`; do
    h=`sips -g pixelHeight $v | tail -1 | sed "s/.* //"`
    w=`sips -g pixelWidth $v | tail -1 | sed "s/.* //"`
    anzahl=`echo "$h*$w" | bc`;
    echo "Anzahl Pixel in $v ($w x $h) ist $anzahl";
    if [[ $anzahl -gt $MAXsize ]]; then
    factor=`echo "scale=5 ; sqrt($MAXsize / $anzahl) " | bc`;
    echo "Faktor: $factor";
    newWidth=`echo "scale=5 ; $w * $factor" | bc`;
    newHeight=`echo "scale=5 ; $h * $factor" | bc`;
    echo "$v Neu: $newWidth x $newHeight";
    sips -z $newHeight $newWidth $v
    echo " ";
    fi
done
