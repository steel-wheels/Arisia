# Document type

THis is contents of Info.plist file.

~~~
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDocumentTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeName</key>
			<string>JavaScript Package</string>
			<key>CFBundleTypeRole</key>
			<string>Viewer</string>
			<key>LSHandlerRank</key>
			<string>Default</string>
			<key>LSItemContentTypes</key>
			<array>
				<string>jspkg</string>
			</array>
			<key>NSDocumentClass</key>
			<string>NSDocument</string>
		</dict>
	</array>
	<key>UTImportedTypeDeclarations</key>
	<array>
		<dict>
			<key>UTTypeConformsTo</key>
			<array>
				<string>com.apple.package</string>
			</array>
			<key>UTTypeDescription</key>
			<string>JavaScript Package</string>
			<key>UTTypeIcons</key>
			<dict/>
			<key>UTTypeIdentifier</key>
			<string>gitlab.com.steewheels.jspkg</string>
			<key>UTTypeTagSpecification</key>
			<dict>
				<key>public.filename-extension</key>
				<array>
					<string>jspkg</string>
				</array>
				<key>public.mime-type</key>
				<array>
					<string>application</string>
				</array>
			</dict>
		</dict>
	</array>
</dict>
</plist>

~~~

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



