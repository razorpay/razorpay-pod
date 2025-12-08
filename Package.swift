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
            path: "Pod/RazorpayStandard.xcframework"
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