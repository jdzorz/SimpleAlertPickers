#
#  Be sure to run `pod spec lint SliderFramework.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = 'MMBAlertsPickers'
  s.version      = '1.1.2'
  s.summary      = 'Advanced usage of UIAlertController with TextField, DatePicker, PickerView, TableView and CollectionView adapted for using in DialogSDK'
  s.homepage     = 'https://github.com/MahmoudMMB/MMBAlertsPickers'
  s.license      = 'MIT'
  s.author       = { 'MahmoudMMB' => 'mmbelbeisi@gmail.com' }
  s.platform     = :ios, '10.0'
  s.swift_version = '4.2'
  s.source       = { :git => 'https://github.com/MahmoudMMB/MMBAlertsPickers.git', :tag => s.version }
  s.source_files  = 'Source/**/*.{swift}'
  s.resource_bundles  = {
    'Countries' => 'Source/Pickers/Locale/Countries.bundle/**'
  }
  s.resources = 'Example/Resources/*.xcassets'

end
