// swift-tools-version: 5.9
import PackageDescription

let packageVersion = "1.5.4-rc.3"

let binaryVersion = "1.5.4-rc.3"

let package = Package(
    name: "RazorpayCheckout",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "RazorpayCheckout", targets: ["RazorpayCheckout", "RazorpayBinary", "RazorpayCore", "RazorpayStandard"]),
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
            checksum: "e86424f7d6e0596191cee639f8aab1c098c44e39bb29cd5d6f4e2beee69824b6"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCore.xcframework.zip",
            checksum: "35f9dc08dd69e8b7945420d1d9929f6109af6dfff4839e0303315b5bd31df5a2"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayStandard.xcframework.zip",
            checksum: "27f930242824d51dc1ad74b7e88d17ab9936a161a6b6d08a620a95e96ce219bb"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCustom.xcframework.zip",
            checksum: "075f711d3c5e1e96f74c17efcb0f01dbaf01752a3e9049dea4a1a79ce8e833e0"
        ),
        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
        .plugin(
            name: "ShowVersions",
            capability: .command(
                intent: .custom(verb: "show-versions", description: "Print versions of all downstream xcframeworks bundled in this SDK"),
                permissions: []
            )
        ),
    ],
    swiftLanguageVersions: [.v5]
)
