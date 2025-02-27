// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.4.0"


let package = Package(
    name: "RazorpayCheckout",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RazorpayCheckout",
            targets: ["RazorpayCheckout", "Razorpay"]
        ),
    ],
    targets: [
        .target(
            name: "RazorpayCheckout",
            path: "RazorpayCheckout/Sources/RazorpayCheckoutCore"
        ),
        .binaryTarget(
            name: "Razorpay",
            path: "Pod/Razorpay.xcframework"
        )
    ],
    swiftLanguageVersions: [.v5]
)
