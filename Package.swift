// swift-tools-version: 5.9
import PackageDescription

let packageVersion = "1.5.4-rc.1"

let binaryVersion = "1.5.4-rc.1"

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
            checksum: "3fc6a373f0165970a946a43165e84eca14b66a57133e33ba7062746a03acd854"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCore.xcframework.zip",
            checksum: "b0f4a23697ab4a4e5095e76e671f96441ac0a8e788464e7eceb68d718f746fb1"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayStandard.xcframework.zip",
            checksum: "4bf49fff33bee0debdf4d64298b90bb7ee5bb90667b692117454dd92e3276174"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCustom.xcframework.zip",
            checksum: "9ffa3fd413b81014af9d0ca896285901a0d3562c33e5a34fef4ed935a54e9b51"
        ),
        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

