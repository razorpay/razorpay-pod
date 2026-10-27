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
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.8/Razorpay.xcframework.zip",
            checksum: "4c22de51214f93927ee87dceb07e1c72ffa9fc3be9735eaeda22ab4e4788a4c1"
        ),

        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.9/RazorpayStandard.xcframework.zip",
            checksum: "cf5baa110763f3800c3739d470dcd6e4a083d625b524fe039d74ee5bcaeffbc3"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.8/RazorpayCore.xcframework.zip",
            checksum: "e1011f0f2ffd411cc9f3db7832493fe1617f312412c8f6a42f937c42bd77c740"
        ),

        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
