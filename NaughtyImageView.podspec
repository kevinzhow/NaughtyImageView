Pod::Spec.new do |s|

  s.name         = "NaughtyImageView"
  s.version      = "0.2.4"
  s.summary      = "UIImageView Can Animate Sprite Image"

  s.description  = <<-DESC
                   UIImageView Can Animate Sprite Image with Progress control.
                   DESC

  s.homepage     = "https://github.com/kevinzhow/NaughtyImageView"
  s.screenshots  = "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "kevinzhow" => "kevinchou.c@gmail.com" }
  s.social_media_url   = "http://twitter.com/kevinzhow"

  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"

  s.source       = { :git => "https://github.com/kevinzhow/NaughtyImageView.git", :tag => s.version }
  s.source_files  = "NaughtyImageView/Source/*.swift"
  s.requires_arc = true

end
