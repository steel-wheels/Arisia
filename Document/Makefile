#
#
#

root_dir = .
include Makefile.inc

srcs	= arisia-components.md4 \
	  arisia-storage.md4 \
	  arisia-lang.md4 \
	  arisia-library.md4 \
	  install.md4 \
	  dev-flow.md4 \
	  database.md4 \
	  resource.md4

dsts	= $(srcs:.md4=.md)

%.md : %.md4
	m4 $(m4_opt) $< > $@

all: $(dsts)
	(cd Applications && make)
	(cd Components && make)
	(cd Function && make)
	(cd Config && make)
	(cd Games && make)
	(cd Tips && make)

clean: dummy
	(cd Applications && make clean)
	(cd Components && make clean)
	(cd Function && make clean)
	(cd Config && make clean)
	(cd Games && make clean)
	(cd Tips && make clean)

dummy:

