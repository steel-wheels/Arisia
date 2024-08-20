#
# Makefile.inc
#

inc_opt	= -I../../ArisiaTools/Resource/Library/types \
 -I../../ArisiaCard/Resource/Samples \
 -I../../ArisiaComponents/Resource/Library/types \
 -I..

def_opt = \
 -D KIWI_LIB_TOP=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary \
 -D KIWI_LIB_DOC=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document \
 -D KIWI_ENGINE_DOC=https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiEngine/Document \
 -D ARISIA_TOP=https://gitlab.com/steewheels/arisia/-/blob/main \
 -D ARISIA_DOC=https://gitlab.com/steewheels/arisia/-/blob/main/Document \
 -D ARISIA_SAMPLE=https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaCard/Resource/Samples \
 -D ARISIA_TOOLS_TOP=https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaTools/Document

m4_opt  = -P $(inc_opt) $(def_opt)

%.md : %.md4
	m4 $(m4_opt) $< > $@

