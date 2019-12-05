
Pod::Spec.new do |s|
  s.name = 'ASAHelpers'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'A collection of helpers and extensions'
  s.homepage = 'https://github.com/antenehs/ASAHelpers'
  s.author = "antenehs"
  s.source = { :git => "https://github.com/antenehs/ASAHelpers.git", :tag => s.version }
  s.documentation_url = 'https://github.com/antenehs/ASAHelpers'

  s.ios.deployment_target = '10.0'

  s.swift_versions = ['4.2', '5.0', '5.1']

  s.source_files = 'ASAHelpers/Extensions/*.swift', 'ASAHelpers/Helpers/*.swift', 'ASAHelpers/CustomViews/*.swift', 'ASAHelpers/Scripts/*.sh', 'ASAHelpers/Styling/*.swift'

  s.dependency "Disk"
end