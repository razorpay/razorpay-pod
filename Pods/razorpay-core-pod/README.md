# razorpay-customui-pod

[![Version](https://img.shields.io/cocoapods/v/razorpay-customui-pod.svg?style=flat)](https://cocoapods.org/pods/razorpay-customui-pod)
[![License](https://img.shields.io/cocoapods/l/razorpay-customui-pod.svg?style=flat)](https://cocoapods.org/pods/razorpay-customui-pod)
[![Platform](https://img.shields.io/cocoapods/p/razorpay-customui-pod.svg?style=flat)](https://cocoapods.org/pods/razorpay-customui-pod)

This repository implements pod for Razorpay's CustomUI iOS Framework.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- The prooject deployment target has to be `iOS 10` or later
- Set `# platform :ios, '10.0'` or later

## Installation

### Note:

If your integrating this on Objective-C please replace the line

```
#import <Razorpay/Razorpay.h>
```

with

```
# import <Razorpay/Razorpay-Swift.h> in your viewcontroller.m file
```

razorpay-customui-pod is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'razorpay-customui-pod'
```

### Note:

for older cocoapod versions check [CHANGELOG](https://github.com/razorpay/razorpay-customui-pod/blob/master/CHANGELOG.md).

Refer to the documentation from [here](https://razorpay.com/docs/payment-gateway/ios-integration/custom/)

## Contributing

See the [CONTRIBUTING] document.
Thank you, [contributors]!

## License

razorpay-pod is free software, and may be redistributed
under the terms specified in the [LICENSE] file.

We :heart: open source software!
See [our other supported plugins / SDKs]
or [contact us](mailto:integrations@razorpay.com?subject=Help with iOS Integration using CocoaPods) to help you with integrations.

[cocoapods]: http://cocoapods.org
[razorpay.com/mobile]: https://razorpay.com/mobile
[contributing]: CONTRIBUTING.md
[contributors]: https://github.com/razorpay/razorpay-customui-pod/graphs/contributors
[license]: /LICENSE
[our other supported plugins / sdks]: https://razorpay.com/integrations "List of our supported integrations"
