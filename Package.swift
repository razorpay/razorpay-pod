// swift-tools-version: 5.9
import PackageDescription

let packageVersion = "1.4.1"

let package = Package(
    name: "RazorpayCheckout",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // This product exposes everything needed to use Razorpay
        .library(
            name: "RazorpayCheckout",
            targets: [
                "RazorpayCheckout",
                "Razorpay",
                "RazorpayCore",
                "RazorpayStandard"
            ]
        ),
    ],
    targets: [
        .target(
            name: "RazorpayCheckout",
            dependencies: [
                .target(name: "Razorpay"),
                .target(name: "RazorpayCore"),
                .target(name: "RazorpayStandard"),
            ],
            path: "RazorpayCheckout/Sources/RazorpayCheckoutCore"
        ),

        .binaryTarget(
            name: "Razorpay",
            path: "Pod/core/Razorpay.xcframework"
        ),

        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7/RazorpayStandard.xcframework.zip",
            checksum: "c244d0f76b2c911c07daa1b28349e6610c6ea221dafcc79f150342f401229318"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            path: "Pod/core/RazorpayCore.xcframework"
        ),

        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
