#
# Be sure to run `pod lib lint SimpleAlertPickers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleAlertPickers'
  s.version          = '1.2.0'
  s.summary      = 'Simple usage of UIAlertController with TextField, DatePicker, PickerView, TableView and CollectionView adapted for using in DialogSDK.
      Removes NSPhotoLibraryUsageDescription NSLocationWhenInUseUsageDescription NSContactsUsageDescription NSCameraUsageDescription from the forked MMBAlertsPickers'


# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Simple usage of UIAlertController with TextField, DatePicker, PickerView, TableView and CollectionView adapted for using in DialogSDK.
  Removes NSPhotoLibraryUsageDescription NSLocationWhenInUseUsageDescription NSContactsUsageDescription NSCameraUsageDescription from the forked dillidon alerts-and-pickers
                       DESC

  s.homepage         = 'https://github.com/jdzorz/SimpleAlertPickers'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jideras@hotmail.com' => 'jideras@hotmail.com' }
  s.source           = { :git => 'https://github.com/jdzorz/SimpleAlertPickers.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jdzorz'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5'

  s.source_files = 'Source/**/*.{swift,h,m,xib,storyboard,lproj,bundle}'
  s.resources = ['Source/Pickers/Locale/*.{swift,h,m,xib,bundle}', 'Source/Views/*.{lproj,storyboard}/*.{xib,strings}']
  s.exclude_files = "SimpleAlertPickers/*.plist"
    
end
