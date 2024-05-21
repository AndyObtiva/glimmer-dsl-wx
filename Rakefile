# encoding: utf-8

# Copyright (c) 2023-2024 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "glimmer-dsl-wx"
  gem.homepage = "http://github.com/AndyObtiva/glimmer-dsl-wx"
  gem.license = "MIT"
  gem.summary = %Q{Glimmer DSL for WX}
  gem.description = %Q{Glimmer DSL for WX (wxWidgets Ruby Desktop Development GUI Library). This is a Glimmer GUI DSL for the WxWidgets GUI toolkit using the latest wxruby binding, wxruby3. It supports a declarative hierarchical minimalistic Ruby DSL with Unidirectional/Bidirectional Data-Binding support to enable building desktop applications the Ruby way.}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["Andy Maleh"]
  gem.executables = ['girb']
  gem.files = ['README.md', 'CHANGELOG.md', 'VERSION', 'LICENSE.txt', 'glimmer-dsl-wx.gemspec', 'bin/**/*', 'lib/**/*', 'icons/**/*', 'samples/**/*', 'sounds/**/*', 'docs/**/*']
  gem.require_paths = ['lib', '.']

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "glimmer-dsl-libui #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rake::Task["build"].enhance([:spec])
