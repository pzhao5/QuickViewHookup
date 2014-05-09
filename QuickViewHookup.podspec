#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "QuickViewHookup"
  s.version          = "0.0.1"
  s.summary          = "An easy way to test a view during the developement"
  s.description      = "Allow to change certain property of the view. Simple add it to its ViewController"
  s.homepage         = "https://github.com/pzhao5/QuickViewHookup"
  s.license          = 'MIT'
  s.author           = { "Philip Z" => "pzhao5@uwalumni.com" }
  s.source           = { :git => "https://github.com/pzhao5/QuickViewHookup.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/*'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
