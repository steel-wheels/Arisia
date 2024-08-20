# install_xc.mk

PRODUCT_DIR	= ../Product
BUNDLE_PATH	= binary/bin
BIN_PATH	= binary/bin

PROJECT_NAME	?= ArisiaTools

all: dummy
	echo "usage: make [install_bundle | install_tools | make_package]"

install_bundle: dummy
	xcodebuild install \
	  -scheme $(PROJECT_NAME)Bundle \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BUNDLE_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_tools: install_asc install_adecl install_apkg

install_asc: dummy
	xcodebuild install \
	  -scheme $(PROJECT_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BIN_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_adecl: dummy
	xcodebuild install \
	  -scheme adecl \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BIN_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_apkg: dummy
	xcodebuild install \
	  -scheme apkg \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BIN_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_decls: dummy
	(cd ../Resource && make)

make_package: dummy
	(cd ../Product && make package)

dummy:

