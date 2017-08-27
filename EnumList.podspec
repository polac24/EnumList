Pod::Spec.new do |spec|
  spec.name         = 'EnumList'
  spec.version      = '0.2.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/polac24/EnumList'
  spec.authors      = { 'Bartosz Polaczyk' => 'polac24@gmail.com' }
  spec.summary      = 'List all cases from enum'
  spec.source       = { :git => 'https://github.com/polac24/EnumList.git', :tag => 'v0.2.0' }
  spec.platform = :ios
  spec.ios.deployment_target = '9.0'
  spec.module_name  = 'EnumList'


  spec.subspec 'Core' do |unbox|
    unbox.source_files       = 'Sources/*.swift'
    unbox.dependency 'Unbox', '~> 2.5.0'
  end
  
  spec.subspec 'Unbox' do |unbox|
    unbox.source_files       = 'Sources/Unbox/*.swift'
    unbox.dependency 'Unbox', '~> 2.5.0'
  end
end
