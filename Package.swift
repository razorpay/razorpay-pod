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
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.2/Razorpay.xcframework.zip",
            checksum: "59dfac8b0197c6e151ca93bc0475d69cddb0231e97fd9bc341a563fdc881feb1"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.2/RazorpayCore.xcframework.zip",
            checksum: "6d341e40f333832e25383164498dc6d67ccaedafd49e37d0482c3afddac35faa"
        ),
        .binaryTarget(
            name: "RazorpayStandard",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.3/RazorpayStandard.xcframework.zip",
            checksum: "292bcc749b4368d6c5ba2618d7bfd381053768d345c4731c113cb052d9110ea0"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/1.5.7-rc.2/RazorpayCustom.xcframework.zip",
            checksum: "c4624240be70cdc7b5cd303945fc53d5cc8077615dd265792c052fba6a1a26cb"
        ),

        .testTarget(
            name: "RazorpayCheckoutTests",
            dependencies: ["RazorpayCheckout"],
            path: "RazorpayCheckout/Tests/RazorpayCheckoutTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
