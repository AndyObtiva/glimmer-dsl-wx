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

require 'glimmer/wx/data_bindable'
require 'glimmer/wx/parent'

module Glimmer
  module Wx
    # Proxy for Wx sizer objects
    #
    # Follows the Proxy Design Pattern
    class SizerProxy
      class << self
        def exists?(keyword)
          keyword.end_with?('_sizer') and
            (
              ::Wx.constants.include?(wx_constant_symbol(keyword)) or
              descendant_keyword_constant_map.keys.include?(keyword)
            )
        end
        
        def create(keyword, parent, args, &block)
          sizer_proxy_class(keyword).new(keyword, parent, args, &block)
        end
        
        def sizer_proxy_class(keyword)
          descendant_keyword_constant_map[keyword] || SizerProxy
        end
        
        def new_sizer(keyword, parent, args)
          args = args.clone || []
          if args.last.is_a?(Hash)
            args[-1] = args[-1].clone
          end
          ::Wx.const_get(wx_constant_symbol(keyword)).new(*args)
        end
        
        def wx_constant_symbol(keyword)
          keyword.to_s.camelcase(:upper).to_sym
        end
        
        def constant_symbol(keyword)
          "#{keyword.to_s.camelcase(:upper)}Proxy".to_sym
        end
        
        def keyword(constant_symbol)
          constant_symbol.to_s.underscore.sub(/_proxy$/, '')
        end
        
        def descendant_keyword_constant_map
          @descendant_keyword_constant_map ||= map_descendant_keyword_constants_for(self)
        end
        
        def reset_descendant_keyword_constant_map
          @descendant_keyword_constant_map = nil
          descendant_keyword_constant_map
        end
        
        def map_descendant_keyword_constants_for(klass, accumulator: {})
          klass.constants.map do |constant_symbol|
            [constant_symbol, klass.const_get(constant_symbol)]
          end.select do |constant_symbol, constant|
            constant.is_a?(Module) && !accumulator.values.include?(constant)
          end.each do |constant_symbol, constant|
            accumulator[keyword(constant_symbol)] = constant
            map_descendant_keyword_constants_for(constant, accumulator: accumulator)
          end
          accumulator
        end
      end
      
      include DataBindable
      
      # wx returns the contained LibUI object
      attr_reader :parent_proxy, :wx, :args, :keyword, :block, :content_added
      alias content_added? content_added
      
      def initialize(keyword, parent, args, &block)
        @keyword = keyword
        @parent_proxy = parent
        @args = args
        @block = block
        build_sizer
        post_add_content if @block.nil?
      end
      
      # Subclasses may override to perform post add_content work (normally must call super)
      def post_add_content
        unless @content_added
          @parent_proxy&.post_initialize_child(self)
          @content_added = true
        end
      end
      
      # Subclasses may override to perform post initialization work on an added child
      def post_initialize_child(child)
        # No Op by default
      end
      
      def respond_to?(method_name, *args, &block)
        @wx.respond_to?(method_name, true) ||
          super(method_name, true)
      end
      
      def method_missing(method_name, *args, &block)
        if @wx.respond_to?(method_name, true)
          @wx.send(method_name, *args, &block)
        else
          super
        end
      end
      
      def content(&block)
        Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Libui::SizerExpression.new, @keyword, {post_add_content: @content_added}, &block)
      end
      
      def add(control_proxy, *args, &block)
        @wx.add(control_proxy.wx, *args)
      end
      
      private
      
      def build_sizer
        @wx = SizerProxy.new_sizer(@keyword, @parent_proxy.wx, @args)
        parent_proxy.sizer = @wx if parent_proxy.is_a?(Glimmer::Wx::ControlProxy)
        @wx
      end
    end
  end
end

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
