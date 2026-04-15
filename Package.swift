// swift-tools-version: 5.9
import PackageDescription

let packageVersion = "1.5.2"

let package = Package(
    name: "RazorpayCheckout",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RazorpayCheckout",
            targets: ["RazorpayCheckout"]
        ),
    ],
    dependencies: [
        .package(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod.git",
            branch: "chore/spm-optimisation"
        ),
    ],
    targets: [
        .target(
            name: "RazorpayCheckout",
            dependencies: [
                .product(name: "RazorpayCoreSPM", package: "RazorpayCore"),
                .target(name: "RazorpayStandard"),
            ],
            path: "RazorpayCheckout/Sources/RazorpayCheckoutCore"
        ),

        .binaryTarget(
            name: "RazorpayStandard",
            path: "Pod/RazorpayStandard.xcframework"
        ),

        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
