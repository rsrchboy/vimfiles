# Regenerate our binary spell files
#
# Chris Weyl <cweyl@alumni.drew.edu> 2015

ADDFILES=$(wildcard *.add)
SPLFILES=$(ADDFILES:.add=.add.spl)

.PHONY: spell clean rebuild

spell: $(SPLFILES)

clean:
	rm *.add.spl

rebuild: clean
	$(MAKE) spell

%.add.spl: %.add
	vim --cmd ':mkspell! $@ $<' --cmd ':qall'
