#
#
#

apkg_cmd = /usr/local/libexec/arisia/bin/apkg

GAME_03	= 03_Animal.jspkg

all: game_03

game_03: dummy
	$(apkg_cmd) $(GAME_03)
	(cd $(GAME_03) && make clean && make)

clean: dummy
	(cd $(GAME_03)  && make clean)

dummy:

