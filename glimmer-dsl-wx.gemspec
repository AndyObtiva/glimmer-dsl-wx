# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: glimmer-dsl-wx 0.0.5 ruby lib .

Gem::Specification.new do |s|
  s.name = "glimmer-dsl-wx".freeze
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze, ".".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2023-06-24"
  s.description = "Glimmer DSL for WX (wxWidgets Ruby Desktop Development GUI Library). This is a Glimmer GUI DSL for the WxWidgets GUI toolkit using the wxruby3 binding.".freeze
  s.email = "andy.am@gmail.com".freeze
  s.executables = ["girb".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md",
    "VERSION",
    "bin/girb",
    "bin/girb_runner.rb",
    "glimmer-dsl-wx.gemspec",
    "icons/glimmer.png",
    "lib/glimmer-dsl-wx.rb",
    "lib/glimmer-dsl-wx/ext/glimmer.rb",
    "lib/glimmer/dsl/wx/bind_expression.rb",
    "lib/glimmer/dsl/wx/control_expression.rb",
    "lib/glimmer/dsl/wx/data_binding_expression.rb",
    "lib/glimmer/dsl/wx/dsl.rb",
    "lib/glimmer/dsl/wx/listener_expression.rb",
    "lib/glimmer/dsl/wx/observe_expression.rb",
    "lib/glimmer/dsl/wx/open_box_expression.rb",
    "lib/glimmer/dsl/wx/operation_expression.rb",
    "lib/glimmer/dsl/wx/property_expression.rb",
    "lib/glimmer/dsl/wx/shine_data_binding_expression.rb",
    "lib/glimmer/proc_tracker.rb",
    "lib/glimmer/wx/control_proxy.rb",
    "lib/glimmer/wx/control_proxy/frame_proxy.rb",
    "lib/glimmer/wx/data_bindable.rb",
    "lib/glimmer/wx/parent.rb",
    "samples/art/wxruby-128x128.png",
    "samples/art/wxruby-256x256.png",
    "samples/art/wxruby-64x64.png",
    "samples/art/wxruby.ico",
    "samples/art/wxruby.png",
    "samples/glimmer_new/hello_button.rb",
    "samples/glimmer_new/hello_button2.rb",
    "samples/glimmer_new/hello_world.rb",
    "samples/glimmer_new/hello_world2.rb",
    "samples/minimal/mondrian.ico",
    "samples/minimal/mondrian.png",
    "samples/minimal/nothing.rb",
    "samples/minimal/tn_minimal.png",
    "samples/minimal/tn_nothing.png"
  ]
  s.homepage = "http://github.com/AndyObtiva/glimmer-dsl-wx".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.3".freeze
  s.summary = "Glimmer DSL for WX".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<glimmer>.freeze, ["~> 2.7.3"])
    s.add_runtime_dependency(%q<os>.freeze, [">= 1.0.0", "< 2.0.0"])
    s.add_runtime_dependency(%q<wxruby3>.freeze, [">= 0.9.0.pre.beta.14", "<= 2.0.0"])
    s.add_development_dependency(%q<juwelier>.freeze, [">= 2.4.9", "< 3.0.0"])
    s.add_development_dependency(%q<stringio>.freeze, ["= 3.0.1"])
    s.add_development_dependency(%q<psych>.freeze, ["= 4.0.3"])
    s.add_development_dependency(%q<json>.freeze, ["= 2.6.1"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rake-tui>.freeze, [">= 0.2.1"])
    s.add_development_dependency(%q<puts_debuggerer>.freeze, ["~> 0.13.1"])
    s.add_development_dependency(%q<coveralls>.freeze, ["= 0.8.23"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16.1"])
    s.add_development_dependency(%q<simplecov-lcov>.freeze, ["~> 0.7.0"])
  else
    s.add_dependency(%q<glimmer>.freeze, ["~> 2.7.3"])
    s.add_dependency(%q<os>.freeze, [">= 1.0.0", "< 2.0.0"])
    s.add_dependency(%q<wxruby3>.freeze, [">= 0.9.0.pre.beta.14", "<= 2.0.0"])
    s.add_dependency(%q<juwelier>.freeze, [">= 2.4.9", "< 3.0.0"])
    s.add_dependency(%q<stringio>.freeze, ["= 3.0.1"])
    s.add_dependency(%q<psych>.freeze, ["= 4.0.3"])
    s.add_dependency(%q<json>.freeze, ["= 2.6.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rake-tui>.freeze, [">= 0.2.1"])
    s.add_dependency(%q<puts_debuggerer>.freeze, ["~> 0.13.1"])
    s.add_dependency(%q<coveralls>.freeze, ["= 0.8.23"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.16.1"])
    s.add_dependency(%q<simplecov-lcov>.freeze, ["~> 0.7.0"])
  end
end

