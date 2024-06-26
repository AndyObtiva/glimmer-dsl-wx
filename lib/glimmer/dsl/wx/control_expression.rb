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

require 'glimmer/dsl/expression'
require 'glimmer/dsl/parent_expression'

module Glimmer
  module DSL
    module Wx
      class ControlExpression < Expression
        include ParentExpression
  
        def can_interpret?(parent, keyword, *args, &block)
          Glimmer::Wx::ControlProxy.exists?(keyword)
        end
  
        def interpret(parent, keyword, *args, &block)
          Glimmer::Wx::ControlProxy.create(keyword, parent, args, &block)
        end
        
        def around(parent, keyword, args, block, &interpret_and_add_content)
          # TODO refactor/extract this logic to a FrameExpression
          if keyword == 'frame'
            ::Wx::App.run do
              frame_proxy = interpret_and_add_content.call
              app_name = frame_proxy.app_name || frame_proxy.title
              self.app_name = app_name unless app_name.nil?
            end
          else
            interpret_and_add_content.call
          end
        end
        
        def add_content(parent, keyword, *args, &block)
          options = args.last.is_a?(Hash) ? args.last : {post_add_content: true}
          options[:post_add_content] = true if options[:post_add_content].nil?
          super
          parent&.post_add_content if options[:post_add_content]
        end
      end
    end
  end
end

require 'glimmer/wx/control_proxy'
