# Define a global platform for MyPokéDex
platform :ios, '12.0'

# Suppresses master specs repo warning
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

target 'PokedexApp' do
  # Use dynamic frameworks (Swift-friendly)
  use_frameworks!
  
  # Pods for MyPokéDex
  pod 'Kingfisher'
  pod 'CocoaAsyncSocket'
  pod 'lottie-ios'
  pod 'VerticalCardSwiper', :git => 'https://github.com/JoniVR/VerticalCardSwiper.git'
  pod 'Loaf'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
      end
    end
  end
