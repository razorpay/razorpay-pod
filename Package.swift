// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let packageVersion = "1.3.4"

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
            checksum: "7a9aee4f56d1ff0bbedc19451b0c01f26640cb9b4b043502b6e8b3d1e1e3bbbe"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
