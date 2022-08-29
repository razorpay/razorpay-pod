#
# Be sure to run `pod lib lint razorpay-pod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "razorpay-pod"
  s.version          = "1.2.9"
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
  s.author           = { "razorpay" => "support@razorpay.com"}
  s.source           = { :git => "https://github.com/razorpay/razorpay-pod.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/razorpay'

  s.platform     = :ios, '10.0'
  s.exclude_files = 'UpdatePod.sh'

  s.vendored_frameworks = 'Pod/Razorpay.xcframework'
  
  #s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  #s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  # s.prepare_command = <<-CMD
  #   chmod 777 ./Pod/SelectDefaultXcode.sh
  #   sh ./Pod/SelectDefaultXcode.sh
  # CMD

end
