# run me with: wish test.tcl [<path/to/font.ttf>]

proc save_list {filename list} {
    set f [open ${filename} w]
    foreach x $list {
        puts $f "${x}"
    }
}
proc ldiff {a b} {
    lmap elem $a { expr {$elem in $b ? [continue] : $elem} }
}

proc myputs args {
    foreach arg $args {
        puts "$arg"
    }
}

set font [lindex $::argv 0]
if { $font eq "" } {
    # if not font is given, use a default one
    set font "../pure-data/font/DejaVuSansMono.ttf"
}

# load the extension
myputs "loading pdfontloader.dll"
load ./pdfontloader.dll

# {DejaVu Sans Mono} should be added to the end of available fonts...
set families0 [font families]
myputs "last font BEFORE: [lindex $families0 end]"
pdfontloader::load $font
set families1 [font families]
myputs "last font AFTER: [lindex $families1 end]"

# but in reality it seems it doesn't.
# so instead we calculate the difference
set newfamilies [ldiff $families1 $families0]
if { $newfamilies ne {} } {
    set family [lindex $newfamilies 0]
    myputs "loaded font ${family}"
} else {
    set family "DejaVu Sans Mono"
    myputs "no new fonts loaded,... using ${family}"
}
#set family "DejaVu Sans MonoXXX"

# for debugging, we might want to print the new and old families
if { 0 } {
    save_list families0.txt $families0
    save_list families1.txt $families1
    save_list diff.txt $newfamilies
}

set text "Hello World 0123"
#set text $family

# create font using family name and a label to use it
set myfont [font create -family ${family} -size 48]
label .mylabel -font ${myfont} -text ${text}
pack .mylabel
