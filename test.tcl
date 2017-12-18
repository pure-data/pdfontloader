# run me with: wish test.tcl

# load the extension
puts "loading pdfontloader.dll"
load ./pdfontloader.dll

# {DejaVu Sans Mono} should be added to the end of available fonts
puts "last font BEFORE: [lindex [font families] end]"
pdfontloader::load ../pure-data/font/DejaVuSansMono.ttf
puts "last font AFTER: [lindex [font families] end]"

# create font using family name and a label to use it
set myfont [font create -family "DejaVu Sans Mono" -size 48]
label .mylabel -font $myfont -text "Hello World 0123"
pack .mylabel
