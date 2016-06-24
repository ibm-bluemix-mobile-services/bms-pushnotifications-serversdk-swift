import PackageDescription

let package = Package(
	name: "BluemixPushNotifications",
    dependencies: [
        .Package(url: "https://github.com/ibm-bluemix-mobile-services/bluemix-simple-http-client-swift.git", majorVersion: 0, minor: 3),
        .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 9, minor: 0)
    ]
)
