Pod::Spec.new do |spec|
  spec.name         = 'APIHelper'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/elielamora/SwiftAPIHelper'
  spec.authors      = { 'Eliel Amora' => 'elielamora@gmail.com' }
  spec.summary      = 'A library to connect to restful apis faster'
  spec.source       = { :git => 'https://github.com/elielamora/SwiftAPIHelper.git', :tag => 'v0.0.1' }
  spec.source_files = 'API.swift'
end
