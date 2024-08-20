#
# Makefile
#

PROJECT_DIR	?= .

apkg_command	= /usr/local/libexec/arisia/bin/apkg

res_dir	= $(PROJECT_DIR)/../Resource

all: dummy
	if [ -x $(apkg_command) ] ; then \
		(cd $(res_dir) ; $(apkg_command) Home.jspkg) ; \
		(cd $(res_dir) ; $(apkg_command) Search.jspkg) ; \
		echo "done make package" ; \
	fi
	(cd $(res_dir)/Home.jspkg && make)
	(cd $(res_dir)/Search.jspkg && make)
	(cd $(res_dir)/Samples && make)
	(cd $(res_dir)/Games && make)

clean: dummy
	(cd $(res_dir)/Home.jspkg && make clean)
	(cd $(res_dir)/Search.jspkg && make clean)
	(cd $(res_dir)/Samples && make clean)

dummy:

