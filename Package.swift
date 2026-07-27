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
            url: "https://github.com/razorpay/razorpay-pod/releases/download/REL_CORE/Razorpay.xcframework.zip",
            checksum: "CKSUM_WRAPPER"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/REL_CORE/RazorpayCore.xcframework.zip",
            checksum: "CKSUM_CORE"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/REL_STANDARD/RazorpayStandard.xcframework.zip",
            checksum: "CKSUM_STANDARD"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/REL_CUSTOM/RazorpayCustom.xcframework.zip",
            checksum: "CKSUM_CUSTOM"
        ),

        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
