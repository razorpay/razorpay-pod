// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RazorpayCheckout",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "RazorpayCheckout", targets: ["RazorpayCheckout", "Razorpay", "RazorpayCore", "RazorpayStandard"]),
        .library(name: "RazorpayCustomUI",  targets: ["RazorpayCustomUI"]),
    ],
    targets: [
        .target(
            name: "RazorpayCheckout",
            dependencies: ["Razorpay", "RazorpayCore", "RazorpayStandard"],
            path: "RazorpayCheckout/Sources/RazorpayCheckoutCore"
        ),
        .target(
            name: "RazorpayCustomUI",
            dependencies: ["Razorpay", "RazorpayCore", "RazorpayCustom"],
            path: "RazorpayCustomUI/Sources"
        ),

        .binaryTarget(
            name: "Razorpay",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.1/Razorpay.xcframework.zip",
            checksum: "b54861f87d9b3b7f5a758c38b9a78a0c1d09193d89f3a2f410e4c1f79521a1b5"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.1/RazorpayCore.xcframework.zip",
            checksum: "d37742f8dfdf76512897d31d08ded951a920733ad58e6b3f8a154e736d16e111"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.1/RazorpayStandard.xcframework.zip",
            checksum: "432c883637cc47851eb5f2dadacd68d72b466c06cd0c51ac20f27fb37a708975"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.1/RazorpayCustom.xcframework.zip",
            checksum: "fa3bfa829c7025e7822f0574b5f3d0ca727cb4109a3b43de0792943b8559a9a3"
        ),

        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
