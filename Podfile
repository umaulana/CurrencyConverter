# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'CurrencyConverter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CurrencyConverter

  # Reactive
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'

  #Networking
  pod 'Alamofire'

  # developer tools
  pod 'FLEX', $flex_version, :configurations => ['Debug']

  target 'CurrencyConverterTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '6.5.0'
    pod 'RxTest', '6.5.0'
  end

  target 'CurrencyConverterUITests' do
    # Pods for testing
  end

end
