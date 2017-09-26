platform :ios, '10.0'

target_name = 'ladder-client'

use_frameworks!
project target_name

target target_name do
  # font
  pod 'ionicons'

  # ui
  pod 'LGRefreshView'

  # json parser
  pod 'SwiftyJSON'

  # network
  pod 'ISHTTPOperation'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

