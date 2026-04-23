// swift-tools-version: 5.9
import PackageDescription

let packageVersion = "1.5.4-rc.2"

let binaryVersion = "1.5.4-rc.2"

let package = Package(
    name: "Razorpay",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "RazorpayCheckout", targets: ["RazorpayCheckout"]),
        .library(name: "RazorpayCustomUI",  targets: ["RazorpayCustomUI"]),
    ],
    targets: [
        .target(
            name: "RazorpayCheckout",
            dependencies: ["RazorpayBinary", "RazorpayCore", "RazorpayStandard"],
            path: "RazorpayCheckout/Sources/RazorpayCheckoutCore"
        ),
        .target(
            name: "RazorpayCustomUI",
            dependencies: ["RazorpayBinary", "RazorpayCore", "RazorpayCustom"],
            path: "RazorpayCustomUI/Sources"
        ),
        .binaryTarget(
            name: "RazorpayBinary",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/Razorpay.xcframework.zip",
            checksum: "c0399b16b728f183b792a5122cdf46fce718d169ae57b5c85aff00a98dc67ba2"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCore.xcframework.zip",
            checksum: "4dbcdca44ab913627e00303da351fec4de4ce0a221937832e30b45a8a9a61ac5"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayStandard.xcframework.zip",
            checksum: "655480e7c44021d3dd9e7457c946b1844b896e8998ead1512e48028c4b443ff6"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCustom.xcframework.zip",
            checksum: "d12808fc71519e8d084b2e4e15bf08e537f63c0b76f10130f1012e284a9247a9"
        ),
        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

