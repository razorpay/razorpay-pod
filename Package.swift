// swift-tools-version: 5.9
import PackageDescription

let packageVersion = "1.4.1"

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
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.8/Razorpay.xcframework.zip",
            checksum: "2465ee91b769a0ed67f6e255bd123ab19dc8613c00a077b99faab5e0610f6141"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.8/RazorpayCore.xcframework.zip",
            checksum: "e1011f0f2ffd411cc9f3db7832493fe1617f312412c8f6a42f937c42bd77c740"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.8/RazorpayStandard.xcframework.zip",
            checksum: "60db02c4ff70ddd3d52bfd411277d9be5b3f467f39880d19cc70975c6575b76b"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.8/RazorpayCustom.xcframework.zip",
            checksum: "35acdf3571255138c175173aa9052755d04be577d284543986e2e1150ae0a71b"
        ),

        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
