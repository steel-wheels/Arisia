# install_xc.mk

PROJECT_NAME ?= ArisiaCard
APP_PATH     ?= /Applications

install_app: macos ios

macos: dummy
	xcodebuild install \
	  -scheme $(PROJECT_NAME)_macOS \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  PRODUCT_NAME=$(PROJECT_NAME) \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  SKIP_INSTALL=NO \
	  INSTALL_PATH=$(APPL_PATH) \
	  ONLY_ACTIVE_ARCH=NO

ios: dummy
	xcodebuild install \
	  -scheme $(PROJECT_NAME)_iOS \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="generic/platform=iOS" \
	  -configuration Release \
	  -sdk iphoneos \
	  PRODUCT_NAME=$(PROJECT_NAME) \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  SKIP_INSTALL=NO \
	  ONLY_ACTIVE_ARCH=NO

dummy:

