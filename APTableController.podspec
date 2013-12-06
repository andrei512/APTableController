Pod::Spec.new do |s|
  s.name         = "APTableController"
  s.version      = "0.0.1"
  s.summary      = "easy to use table views"

  s.description  = <<-DESC
                   DESC
  s.homepage     = "https://github.com/andrei512/APTableController"
  s.license      = 'MIT'
  s.author       = { "andrei512" => "puni.andrei23@gmail.com" }
  s.platform     = :ios, '6.0'

  s.source       = { :git => "https://github.com/andrei512/APTableController.git", :tag => "0.0.1" }

  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.requires_arc = true

  s.dependency 'APUtils'
end
