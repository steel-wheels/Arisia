#
#
#

TARGET		= package/ArisiaTools.pkg
SIGN		= "Developer ID Installer: Tomoo Hamada (TR2DNF3P93)"

PKG_PATH	= /usr/local/libexec/arisia
VERSION		= "1.0"

all: package notarize

package: dummy
	rm -f $(TARGET)
	pkgbuild --identifier "gitlab.com.steelwheels.ArisiaTools" \
		 --install-location $(PKG_PATH) \
		 --version $(VERSION) \
		 --root binary  \
		 --sign $(SIGN) \
		 --timestamp \
		$(TARGET)

notarize: dummy
	xcrun notarytool submit $(TARGET) \
			 --keychain-profile "Steel Wheels Project" \
			 --wait

log: dummy
	xcrun notarytool log <UUID> --keychain-profile "Steel Wheels Project"

clean:
	rm -f $(TARGET)

dummy:

