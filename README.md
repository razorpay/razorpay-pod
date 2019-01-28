# razorpay-pod

[![Version](https://img.shields.io/cocoapods/v/razorpay-pod.svg?style=flat)](http://cocoapods.org/pods/razorpay-pod)
[![License](https://img.shields.io/cocoapods/l/razorpay-pod.svg?style=flat)](http://cocoapods.org/pods/razorpay-pod)
[![Platform](https://img.shields.io/cocoapods/p/razorpay-pod.svg?style=flat)](http://cocoapods.org/pods/razorpay-pod)

This repository implements pod for Razorpay's iOS Framework.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation | Docs

### Note:
We no longer support Swift 3 , moving forward only the latest version of swift will be supported.We only support a minimum deployment target of iOS 10+.This decision has been taken based on the following link that clearly shows that the number of devices running iOS 10 are very minimal.
https://developer.apple.com/support/app-store/

### Note: 
We now support another optional parameter to the open method - displayController
When this parameter is specified , the razorpay controller will be pushed on to this controller's navigation controller if present or presented on this controller if absent.

For example, the swift call is 

```
razorpay.open(options, displayController: self)
```

### Note:
If your integrating this on OBJC please replace the line
```
#import <Razorpay/Razorpay.h>
```
with 
```
# import <Razorpay/Razorpay-Swift.h> in your viewcontroller.m file
```

razorpay-pod is available through [CocoaPods]. To install
it, simply add the following line to your Podfile

For version 1.0.27(Framework Compiled in Swift version 4.2.1, Use it if you are using Xcode version 10 and above)

```ruby
pod 'razorpay-pod', '1.0.27'
```


Refer to the documentation from [here](https://razorpay.com/docs/ios/) 

## Contributing

See the [CONTRIBUTING] document.
Thank you, [contributors]!

## License

razorpay-pod  is free software, and may be redistributed
under the terms specified in the [LICENSE] file.

We :heart: open source software!
See [our other supported plugins / SDKs]
or [contact us](mailto:integrations@razorpay.com?subject=Help with iOS Integration using CocoaPods) to help you with integrations.

  [CocoaPods]: http://cocoapods.org
  [razorpay.com/mobile]: https://razorpay.com/mobile
  [CONTRIBUTING]: CONTRIBUTING.md
  [contributors]: https://github.com/razorpay/razorpay-pod/graphs/contributors
  [LICENSE]: /LICENSE
  [our other supported plugins / SDKs]: https://razorpay.com/integrations "List of our supported integrations"
