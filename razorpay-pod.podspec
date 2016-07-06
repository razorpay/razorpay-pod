#
# Be sure to run `pod lib lint razorpay-pod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "razorpay-pod"
  s.version          = "0.12.0"
  s.summary          = "CocoaPod implementation of Razorpay's Payment SDK"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
  Razorpay is a payments platform for e-commerce businesses in India. Razorpay
helps businesses accepts online payments via Credit Card, Debit Card, Net banking
 and Wallets from their end customers. Razorpay provides a secure link between
 merchant website, various issuing institutions, acquiring Banks and the payment
  networks. Razorpay is a developer oriented payment gateway and focuses on
  essentials such as 24x7 support, one line integration code and checkout
  experiences that are very customer friendly.
                       DESC

  s.homepage         = "https://github.com/razorpay/razorpay-pod"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "akshaybhalotia" => "akshay.bhalotia@razorpay.com" }
  s.source           = { :git => "https://github.com/razorpay/razorpay-pod.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/razorpay'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  # s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'razorpay-pod' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreTelephony', 'SystemConfiguration'
  s.vendored_frameworks = 'Pod/Razorpay.framework'
  # s.dependency 'AFNetworking', '~> 2.3'
end
