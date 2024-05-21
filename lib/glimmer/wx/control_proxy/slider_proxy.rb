# Copyright (c) 2021-2024 Andy Maleh
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

require 'glimmer/wx/control_proxy'

module Glimmer
  module Wx
    class ControlProxy
      # Proxy for Wx slider double objects
      #
      # Follows the Proxy Design Pattern
      class SliderProxy < ControlProxy
        include ::Wx::IDHelper
        
        class << self
          def new_control(keyword, parent, args)
            args = args.clone || []
            if args.last.is_a?(Hash)
              args[-1] = args[-1].clone
            end
            value = 0
            min = 0
            max = 100
            style = 0
            ::Wx.const_get(wx_constant_symbol(keyword)).new(parent, next_id, value, min, max, style: style)
          end
        end
      
        def data_bind_write(property, model_binding)
          handle_listener('on_slider') { model_binding.call(value) } if property == 'value'
        end
      end
    end
  end
end

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
