import PackageDescription

let package = Package(
	name: "BluemixPushNotifications",
    dependencies: [
        .Package(url: "https://github.com/ibm-bluemix-mobile-services/bluemix-simple-http-client-swift.git", majorVersion: 0, minor: 2),
        .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 7, minor: 0)
    ]
)