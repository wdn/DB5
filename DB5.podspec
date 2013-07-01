Pod::Spec.new do |s|
  s.name     = 'DB5'
  s.version  = '1.0'
  s.license  = 'MIT'
  s.summary  = 'App Configuration via Plist'
  s.homepage = 'https://github.com/quartermaster/DB5/'
  s.authors  = { 'Brent Simmons' => '@brentsimmons' }
  s.source   = { :git => 'https://github.com/exister/DB5.git'}
  s.source_files = 'Source/*.{h,m}'
  s.requires_arc = true

  s.ios.deployment_target = '5.0'
  s.ios.frameworks = 'CoreGraphics', 'UIKit', 'Foundation'

end
