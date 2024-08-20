#
#
#

doc_dir		= $(project_dir)/Document
resource_dir	= $(project_dir)/Resource
types_dir	= $(resource_dir)/Library/types

md4_cmd	= $(HOME)/tools/bin/md4 \
		--include $(types_dir) \
		--footer $(doc_dir)/Footer.md

%.md: %.md4
	$(md4_cmd) $< > $@

