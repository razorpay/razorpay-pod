// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let packageVersion = "1.3.8"

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
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(packageVersion)/Razorpay.xcframework.zip",
            checksum: "095cda959931bc812580a1a683d6d2b3fe6b63cb9fa52557c3530363b23a3d33"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
