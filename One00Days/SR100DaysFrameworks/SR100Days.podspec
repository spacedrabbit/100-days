Pod::Spec.new do |spec|
  spec.name = "SR100Days"
  spec.version = "0.0.1"
  spec.summary = "Sample framework, not for real world use."
  spec.homepage = "https://github.com/spacedrabbit/100-days"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "louis" => 'louis.tur@gmail.com' }
  spec.social_media_url = "http://twitter.com/louistur"

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/spacedrabbit/100-days.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "100-days/**/*.{h,swift}"

  spec.dependency "Curry", "~> 1.4.0"
end