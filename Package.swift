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
            checksum: "9ae87b723c7eec3b3a596040757fe26228425cecf6c078f982b933bf477179c4"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCore.xcframework.zip",
            checksum: "962602be84861bfa58e610cd38f2061ac60144958dd1b69d66541bade41c3178"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayStandard.xcframework.zip",
            checksum: "10c5488ab235c2a445e1e01cfc8a4e5daa4f0624a511f955b6c39b0aa87e848f"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCustom.xcframework.zip",
            checksum: "b8f74f509e3aed5adf511f86e0e582d19f5e5010baa1e4a9b648705a61524279"
        ),
        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

