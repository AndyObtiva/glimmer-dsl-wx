# Copyright (c) 2023 Andy Maleh
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

require 'glimmer/wx/parent'

module Glimmer
  module Wx
    class ControlProxy
      # Proxy for Wx frame objects
      #
      # Follows the Proxy Design Pattern
      class FrameProxy < ControlProxy
        include Parent
        
        attr_accessor :app_name
        
        def initialize(keyword, parent, args, &block)
          self.app_name = options.delete(:app_name)
          super(keyword, parent, args, &block)
        end
        
        def title=(value)
          # wxWidgets does not allow setting a frame title if set already
          super if (options[:title] || options['title']).nil?
        end
        
        def post_add_content
          super
          show
        end
      end
    end
  end
end
