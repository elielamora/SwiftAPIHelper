Pod::Spec.new do |spec|
  spec.name         = 'APIHelper'
  spec.version      = '0.0.0
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/elielamora/SwiftAPIHelper'
  spec.authors      = { 'Tony Million' => 'tonymillion@gmail.com' }
  spec.summary      = 'ARC and GCD Compatible Reachability Class for iOS and OS X.'
  spec.source       = { :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' }
  spec.source_files = 'Reachability.{h,m}'
  spec.framework    = 'SystemConfiguration'
end
