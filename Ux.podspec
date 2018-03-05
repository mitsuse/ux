Pod::Spec.new do |spec|
  spec.name = 'Ux'
  spec.version = '0.1.0'
  spec.homepage = 'https://github.com/mitsuse/ux'
  spec.authors = {
    'Tomoya Kose' => 'tomoya@mitsuse.jp',
  }
  spec.summary = 'Extensions for UIKit.'
  spec.source = {
    :git => 'git@github.com:mitsuse/ux.git',
    :tag => "#{spec.version}",
  }
  spec.ios.deployment_target = '10.0'
  spec.source_files = 'Sources/ux/**/*.swift'
  spec.ios.framework = 'UIKit'
  spec.dependency 'RxCocoa', '~> 4.0'
  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
