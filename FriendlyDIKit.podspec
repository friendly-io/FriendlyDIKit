Pod::Spec.new do |s|
    s.name          = "FriendlyDIKit"
    s.version       = "0.1"
    s.summary       = "Swift dependency injection framework"
    s.description   = "Swift dependency injection framework - "
    s.homepage      = "https://github.com/friendly-io/FriendlyDIKit"
    s.license       = { :type => "MIT", :file => "LICENSE" }
    s.author        = { "Friendly.io" => "contact@friendly.io" }
    #s.source        = { :git => "https://github.com/friendly-io/FriendlyDIKit.git" }
    s.source        = { :git => "https://github.com/friendly-io/FriendlyDIKit.git", :tag => s.version }
    s.ios.deployment_target = "9.0"
    s.macos.deployment_target = "10.12"

    s.requires_arc = true
    s.source_files = "Sources/**/*.{h,swift}"

    s.dependency 'NSLogger'
    s.dependency 'NSLogger/Swift'
end
