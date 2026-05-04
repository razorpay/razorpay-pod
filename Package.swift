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
            checksum: "8a0859dd0c29259f71a239526b0d1cfe8769f71193cb664b92f79782b02a0264"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCore.xcframework.zip",
            checksum: "701340e9d0d7d1b628c5a51690218cbec4a2672adf00f0bf8326a63c518e6049"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayStandard.xcframework.zip",
            checksum: "d1bced86c7eb85d396b2755881af1e6b6f162456ca89320a7e7ef77ef4e7adcd"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCustom.xcframework.zip",
            checksum: "0450d6648d534beac26af3ebe4b37f1785a6ad40a7a84a700354e61aef47c045"
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
