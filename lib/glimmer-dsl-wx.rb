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

$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

# External requires
require 'glimmer'
# require 'perfect-shape'
# require 'logging'
# require 'puts_debuggerer' if ENV['pd'].to_s.downcase == 'true'
# require 'super_module'
# require 'color'
require 'os'
# require 'equalizer'
require 'array_include_methods'
require 'facets/hash/stringify_keys'
require 'facets/string/underscore'
require 'wx'

# Internal requires
# require 'ext/glimmer/config'
require 'glimmer-dsl-wx/ext/glimmer'
require 'glimmer/dsl/wx/dsl'
Glimmer::Config.loop_max_count = -1
Glimmer::Config.excluded_keyword_checkers << lambda do |method_symbol, *args|
  method = method_symbol.to_s
  result = false
  result ||= method == 'load_iseq'
end

# begin
#   PutsDebuggerer.printer = lambda { |m| puts m; $stdout.flush}
# rescue
  ##### No Op if puts_debuggerer is not loaded
# end
