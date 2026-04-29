import PackagePlugin

@main
struct ShowVersions: CommandPlugin {
    static let razorpayPodVersion          = "1.5.2"
    static let razorpayVersion             = "1.0.0"
    static let razorpayCoreVersion         = "1.0.4"
    static let razorpayStandardVersion     = "1.5.2"
    static let razorpayCustomVersion       = "2.0.1"

    func performCommand(context: PluginContext, arguments: [String]) throws {
       print("=== Razorpay SDK — Dependency Versions ===")
       print("razorpay-pod:                      \(Self.razorpayPodVersion)")
       print("Razorpay.xcframework:              \(Self.razorpayVersion)")
       print("RazorpayCore.xcframework:          \(Self.razorpayCoreVersion)")
       print("RazorpayStandard.xcframework:      \(Self.razorpayStandardVersion)")
       print("RazorpayCustom.xcframework:        \(Self.razorpayCustomVersion)")
       print("==========================================")
    }
}
