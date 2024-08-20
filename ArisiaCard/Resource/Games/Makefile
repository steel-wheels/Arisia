#
#
#

apkg_cmd = /usr/local/libexec/arisia/bin/apkg

all: bfc

bfc: dummy
	$(apkg_cmd) BattleFieldCode.jspkg
	(cd BattleFieldCode.jspkg && make clean && make)

clean: dummy
	(cd BattleFieldCode.jspkg && make clean)

dummy:

