# Regenerate our binary spell files
#
# Chris Weyl <cweyl@alumni.drew.edu> 2015

ADDFILES=$(wildcard *.add)
SPLFILES=$(ADDFILES:.add=.add.spl)

spell: $(SPLFILES)

%.add.spl: %.add
	vim --cmd ':mkspell! $@ $<' --cmd ':qall'
