#
# Makefile
#

tool_dir	= /usr/local/libexec/arisia/bin
adecl_cmd	= $(tool_dir)/adecl

all: dummy
	if [ -f $(adecl_cmd) ] ; then \
		(cd types && $(adecl_cmd) && $(adecl_cmd) -i) ; \
	fi

clean:
	rm -f $(dst_decl)

dummy:

