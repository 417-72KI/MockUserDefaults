Pod::Spec.new do |s|
    s.name         = "MockUserDefaults"
    s.version      = "1.0"
    s.summary      = "Mocking UserDefaults"
        
    s.description  = <<-DESC
                    MockUserDefaults is a simple replacement for NSUserDefaults/UserDefaults to make test easier.
                    DESC
    
    s.homepage     = "https://github.com/417-72KI/MockUserDefaults"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    
    s.author       = { "417.72KI" => "417.72ki@gmail.com" }
    s.social_media_url   = "http://twitter.com/417_72KI"
    
    s.ios.deployment_target = "10.0"
    s.osx.deployment_target = "10.9"
    s.watchos.deployment_target = "3.0"
    s.tvos.deployment_target = "10.0"
    
    s.requires_arc = true
        
    s.source       = { :git => "https://github.com/417-72KI/MockUserDefaults.git", :tag => "#{s.version}" }
    s.source_files = 'MockUserDefaults/**/*.{h,m}'
    s.public_header_files = 'MockUserDefaults/**/*.h'
    s.frameworks   = 'Foundation'
end
    