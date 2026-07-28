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
            checksum: "5ef1640efaf6023fdb2c3e1b660ebd1b37f4af25b5368c94d9d0f62b2a65936b"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.1/RazorpayCore.xcframework.zip",
            checksum: "36acd58c4664e244236739d082c61fea50327c8b4c85470430399ad8c0bcc09d"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.1/RazorpayStandard.xcframework.zip",
            checksum: "370f1247bf285410501bbacaadbe44376aeb2f4130c1e5f2a94b57a9545a7fe1"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.1/RazorpayCustom.xcframework.zip",
            checksum: "d7f55ff4bd13646024403e3a25f135a8171d386265aff7d1061e3d283a2f652f"
        ),

        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
