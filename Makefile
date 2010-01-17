#
# Makefile for TextAs - A simple text adventure engine written in Actionscript
#
# 23rd November 2009
#
# Joony (jonathan.mcallister@gmail.com)
#
#


engine:
	mxmlc src/ch/forea/textas/Main.as -default-size 720 496 -default-background-color=0xA5A5FF -source-path='src/' -debug=true -target-player=10 -output='textas.swf'

run:
	fdb run index.html
