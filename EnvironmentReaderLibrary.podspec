Pod::Spec.new do |spec|

    spec.name                   = 'EnvironmentReaderLibrary'
    spec.version                = '0.0.1'
    spec.license                = 'MIT'
    spec.homepage               = 'https://github***'
    spec.authors                = { 'Qian Kun ZHU' => "zqkun.public@gmail.com" }
    spec.summary                = 'A library can extract PSI and PM2.5 data from NEA and save to local'
    spec.description            = <<-DESC
                                    TODO: Add long description of the pod here.
                                    DESC

    spec.source                 = { :git => 'https://github/***.git', :tag => '0.0.1' }
    spec.ios.deployment_target  = '8.0'
    spec.source_files           = 'EnvironmentReaderLibrary/*.{h,m}'
    spec.requires_arc           = true

    spec.subspec 'Source' do |ss|
        ss.source_files  = 'EnvironmentReaderLibrary/*.{h,m}'
        ss.dependency 'AFNetworking'
    end
end
