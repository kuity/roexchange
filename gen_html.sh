#!/bin/bash

cd dist
declare -a pages=("mats.html" "blueprints.html" "weapon_cards.html" "armor_cards.html" \
  "offhand_cards.html" "headgear_cards.html" "accessory_cards.html" \
  "footgear_cards.html" "garment_cards.html" "cards_by_rarity.html")
declare -a folders=("images/Materials" "images/Blueprints" "images/Cards/Weapon" \
  "images/Cards/Armor" "images/Cards/Offhand" "images/Cards/Headgear" \
  "images/Cards/Accessory" "images/Cards/Footgear" "images/Cards/Garment" \
  "images/Cards/rarity")

for (( i=0; i<${#pages[*]}; ++i )); 
#i in "${arr[@]}"
do
  filename=${pages[$i]}
  folder=${folders[$i]}
  title=`echo $filename | cut -d'.' -f 1`
  echo "$filename, $folder, $title" 
  echo "<html>" > $filename
  echo "  <head>" >> $filename
  echo "  <title>$title</title>" >> $filename
  echo "  <link rel=\"stylesheet\" type=\"text/css\" href=\"template.css\"/>" >> $filename
  echo "  </head>" >> $filename
  echo "  <body>" >> $filename
  #find $folder -type f -printf "        <img src=\"$folder/%f\">\n" >> $filename
  find $folder -name "*.png" \
    -exec sh -c 'printf "    <figure>\n      <img src=\"%s\">\n" "${0}"' {} ';' \
    -exec sh -c 'f=$(basename "{}" .png);echo "      <figcaption>$f</figcaption>\n    </figure>" | tr _ " "' ';' >> $filename
  echo "  </body>" >> $filename
  echo "</html>" >> $filename
done

#filename="index.html"
#cd dist
#echo "<html>" > $filename
#echo "  <head>" >> $filename
#echo "    <title>This is the title of the webpage!</title>" >> $filename
#echo "  <body>" >> $filename
#find images -type f -printf "      <img src=\"images/%f\"/^>\n" >> $filename
#echo "  </body>" >> $filename
#echo "</html>" >> $filename

