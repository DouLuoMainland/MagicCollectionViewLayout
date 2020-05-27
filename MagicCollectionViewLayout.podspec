
Pod::Spec.new do |s|
  s.name             = 'MagicCollectionViewLayout'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MagicCollectionViewLayout.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Sun,Shaobo/MagicCollectionViewLayout'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sun,Shaobo' => 'sunshaobo@baidu.com' }
  s.source           = { :git => 'https://github.com/Sun,Shaobo/MagicCollectionViewLayout.git', :tag => s.version.to_s }

  s.source_files = 'MagicCollectionViewLayout/Classes/**/*'
  s.public_header_files = 'MagicCollectionViewLayout/Classes/**/*.h'
  
end
