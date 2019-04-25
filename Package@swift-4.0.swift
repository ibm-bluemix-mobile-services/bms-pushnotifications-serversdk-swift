// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "IBMPushNotifications",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "IBMPushNotifications", targets: ["IBMPushNotifications"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ibm-bluemix-mobile-services/bluemix-simple-http-client-swift.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "IBMPushNotifications", dependencies: ["SimpleHttpClient"],path: "Sources"),
        .testTarget(name: "IBMPushNotificationsTests", dependencies: ["IBMPushNotifications"]),
    ]
)