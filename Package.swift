import PackageDescription

let package = Package(
	name: "IBMPushNotifications",
    dependencies: [
        .Package(url: "https://github.com/ibm-bluemix-mobile-services/bluemix-simple-http-client-swift.git", majorVersion: 0, minor: 9),
    ]
)
