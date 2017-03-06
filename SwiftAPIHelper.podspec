Pod::Spec.new do |spec|
  spec.name         = 'SwiftAPIHelper'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'Apache License, Version 2.0',
                    :text =>
                    ' Copyright (c) 2017 Eliel Amora
                      Licensed under the Apache License, Version 2.0 (the "License");
                      you may not use this file except in compliance with the License.
                      You may obtain a copy of the License at
                        http://www.apache.org/licenses/LICENSE-2.0
                      Unless required by applicable law or agreed to in writing, software
                      distributed under the License is distributed on an "AS IS" BASIS,
                      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
                      See the License for the specific language governing permissions and
                      limitations under the License.'
                  }
  spec.homepage     = 'https://github.com/elielamora/SwiftAPIHelper'
  spec.authors      = { 'Eliel Amora' => 'elielamora@gmail.com' }
  spec.summary      = 'A library to connect to restful apis faster'
  spec.source       = { :git => 'https://github.com/elielamora/SwiftAPIHelper.git', :tag => '0.0.1' }
  spec.source_files = 'API.swift'
  spec.ios.deployment_target = '9.0'
  spec.osx.deployment_target = '10.10'
end
