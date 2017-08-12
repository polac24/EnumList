Pod::Spec.new do |spec|
  spec.name         = 'EnumList'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/polac24/EnumList'
  spec.authors      = { 'Bartosz Polaczyk' => 'polac24@gmail.com' }
  spec.summary      = 'List all cases from enum'
  spec.source       = { :git => 'https://github.com/polac24/EnumList.git', :tag => 'v0.1.0' }
  spec.module_name  = 'EnumList'

  spec.source_files       = 'Sources/*.swift'
end