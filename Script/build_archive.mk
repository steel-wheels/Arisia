#
# build_archive.mk
#

PROJECT_NAME	?= ArisiaCard
PRODUCT_DIR	= ../Product

macos: archive ipa

archive: dummy
	mkdir -p $(PRODUCT_DIR)
	xcodebuild archive \
	  -scheme $(PROJECT_NAME) \
	  -archivePath $(PRODUCT_DIR)/ArisiaCard.xcarchive \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  CODE_SIGN_IDENTITY="$(DIST_SIGN)" \
	  PROVISIONING_PROFILE_SPECIFIER="ArisiaCard.macOS.profile"

ipa: dummy
	xcodebuild \
	  -exportArchive \
	  -exportPath $(PRODUCT_DIR) \
	  -archivePath $(PRODUCT_DIR)/ArisiaCard.xcarchive \
	  -exportOptionsPlist $(PRODUCT_DIR)/exportOptions.plist \
	  -allowProvisioningUpdates

dummy:

