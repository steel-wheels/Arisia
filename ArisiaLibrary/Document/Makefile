#
#
#

project_dir	= ..
include Makefile.inc

srcs	= Library.md4
dsts	= $(srcs:.md4=.md)

all: $(dsts)
	(cd Function && make)

clean:
	rm -f $(dsts)
	(cd Function && make clean)

