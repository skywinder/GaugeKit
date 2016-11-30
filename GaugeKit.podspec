Pod::Spec.new do |s|
  s.name             = "GaugeKit"
  s.version          = "0.4.0"
  s.summary          = "Kit for building custom gauges + easy reproducible Apple's style ring gauges."
  s.description      = "Kit for building custom gauges + easy reproducible Apple's style ring gauges.
                        ## Features
                        - Cusomizible
                        - Auto-resized
                        - Support `@IBInspectable` & `@IBDesignable`
                        - Written with vanilla swift flavor :wink:"
  s.homepage         = "https://github.com/skywinder/GaugeKit"
  s.screenshots      = ["https://raw.githubusercontent.com/skywinder/GaugeKit/master/Images/GaugeKit_sreenshot.png",
                        "https://raw.githubusercontent.com/skywinder/GaugeKit/master/Images/SWGauge_example.gif",
                        "https://raw.githubusercontent.com/skywinder/GaugeKit/master/Images/ib_example_1.gif"]
  s.license          = 'MIT'
  s.author           = { "Petr Korolev" => "sky4winder@gmail.com" }
  s.source           = { :git => "https://github.com/skywinder/GaugeKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/skywinder'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'GaugeKit/**/*'

  s.public_header_files = 'GaugeKit/**/*.h'
  s.frameworks = 'UIKit', 'QuartzCore'
end
