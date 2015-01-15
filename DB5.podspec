Pod::Spec.new do |s|
  s.name     = 'DB5'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.summary  = 'Fork of DB5'
  s.homepage = 'https://github.com/wdn/DB5/'
  s.authors  = { 'Brent Simmons' => '@brentsimmons',
                 'W. Dana Nuon'  => '@wdnuon'
               }
  s.source   = { :git => 'https://github.com/wdn/DB5.git',
                 :tag => s.version.to_s
               }
  s.source_files = 'Source/*.{h,m}'
  s.requires_arc = true

  s.ios.deployment_target = '5.0'
  s.ios.frameworks = 'CoreGraphics', 'UIKit', 'Foundation'

end
