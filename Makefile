#
# Makefile for TextAs - A simple text adventure engine written in Actionscript
#
# 23rd November 2009
#
# Joony (jonathan.mcallister@gmail.com)
#
#


engine:
	mxmlc src/ch/forea/textas/Main.as -source-path='src/' -debug=true

run:
	fdb run src/ch/forea/textas/Main.swf 
