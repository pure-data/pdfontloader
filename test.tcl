# run me with: wish test.tcl

puts "loading pdloader.dll"
load ./pdloader.dll

puts "BEFORE: [font families]"
pdloader::loadfont ../pure-data/font/DejaVuSansMono.ttf
puts "AFTER: [font families]"

set myfont [font create -family "DejaVu Sans Mono" -size 48]
label .mylabel -font $myfont -text "Hello World 0123"
pack .mylabel
