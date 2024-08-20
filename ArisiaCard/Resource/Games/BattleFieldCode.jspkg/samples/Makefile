#
# Makefile
#

srcs = car.ts
dsts = $(srcs:.ts=.js)

tsc	= npx tsc
tsc_opt	= -t ES2017 --lib "es2017" --declaration --declarationDir ./types \
	  --alwaysStrict --strict --strictNullChecks --pretty

# *.ts -> *.js
%.js: %.ts
	$(tsc) $(tsc_opt) $<

all: types $(dsts)

clean:
	rm -f $(dsts)

types: types/ArisiaPlatform.d.ts types/machine.d.ts

types/ArisiaPlatform.d.ts: ../types/ArisiaPlatform.d.ts
	cp $< $@

types/machine.d.ts: ../types/machine.d.ts
	cp $< $@

