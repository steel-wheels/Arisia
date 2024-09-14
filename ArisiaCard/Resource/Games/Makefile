#
#
#

apkg_cmd = /usr/local/libexec/arisia/bin/apkg

GAME_01 = 01_Acey_Ducey.jspkg
GAME_03	= 03_Animal.jspkg

all: game_01 game_03

game_01: dummy
	$(apkg_cmd) $(GAME_01)
	(cd $(GAME_01) && make clean && make)

game_03: dummy
	$(apkg_cmd) $(GAME_03)
	(cd $(GAME_03) && make clean && make)

clean: dummy
	(cd $(GAME_01)  && make clean)
	(cd $(GAME_03)  && make clean)

dummy:

