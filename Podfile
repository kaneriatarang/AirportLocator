# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AirAsiaAirportLocator' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AirAsiaAirportLocator

  target 'AirAsiaAirportLocatorTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

  target 'AirAsiaAirportLocatorUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5.0'
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')        end
    end
end
