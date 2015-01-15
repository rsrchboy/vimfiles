# Regenerate our binary spell files
# 
# Chris Weyl <cweyl@alumni.drew.edu> 2015

ADDFILES=en.utf-8.add gitcommit.utf-8.add mail.utf-8.add perl.utf-8.add vimwiki.utf-8.add
SPLFILES=$(ADDFILES:.add=.add.spl)

spell: $(SPLFILES)

%.add.spl: %.add
	vim --cmd ':mkspell! $@ $<' --cmd ':qall'
