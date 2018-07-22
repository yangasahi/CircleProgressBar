Pod::Spec.new do |s|
  s.name         = "CircleProgressBar"
  s.version      = "0.0.1"
  s.summary      = "CircleProgressBar is a library for showing diffrent colors progress to a circle progress bar."
  s.homepage     = "https://github.com/yangasahi/CircleProgressBar"
  s.license      = "MIT"
  s.author             = { "yang-xu" => "yang.asahi@gmail.com" }

  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/yangasahi/CircleProgressBar.git", :tag => s.version }

  s.source_files  = "CircleProgressBar/*"

end
