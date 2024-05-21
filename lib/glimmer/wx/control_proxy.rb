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

require 'glimmer/wx/data_bindable'
require 'glimmer/wx/parent'

module Glimmer
  module Wx
    # Proxy for Wx control objects
    #
    # Follows the Proxy Design Pattern
    class ControlProxy
      class << self
        def exists?(keyword)
          ::Wx.constants.include?(wx_constant_symbol(keyword)) or
            descendant_keyword_constant_map.keys.include?(keyword)
        end
        
        def create(keyword, parent, args, &block)
          control_proxy_class(keyword).new(keyword, parent, args, &block)
        end
        
        def control_proxy_class(keyword)
          descendant_keyword_constant_map[keyword] || ControlProxy
        end
        
        def new_control(keyword, parent, args)
          args = args.clone || []
          if args.last.is_a?(Hash)
            args[-1] = args[-1].clone
          end
          ::Wx.const_get(wx_constant_symbol(keyword)).new(parent, *args)
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
        build_control
        post_add_content if @block.nil?
      end
      
      def options
        @args&.last&.is_a?(Hash) ? @args.last : {}
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
      
      # Returns closest frame ancestor or self if it is a frame
      def frame_proxy
        found_proxy = self
        until found_proxy.nil? || found_proxy.is_a?(FrameProxy)
          found_proxy = found_proxy.parent_proxy
        end
        found_proxy
      end
      
      # Returns closest control ancestor
      def control_proxy
        found_proxy = parent_proxy
        until found_proxy.nil? || found_proxy.is_a?(ControlProxy)
          found_proxy = found_proxy.parent_proxy
        end
        found_proxy
      end

      def can_handle_listener?(listener_name)
        listener_name.to_s.start_with?('on_')
        # TODO figure out if there is a way to check this in Wx or not.
#           has_custom_listener?(listener_name)
      end
      
      def handle_listener(listener_name, &listener)
        event = listener_name.to_s.sub('on_', '')
        frame_proxy.wx.send("evt_#{event}", @wx, &listener)
#         elsif has_custom_listener?(listener_name)
#           handle_custom_listener(listener_name, &listener)
#         end
      end
      
      def listeners
        @listeners ||= {}
      end
      
      def listeners_for(listener_name)
        listeners[listener_name] ||= []
      end
      
      def has_custom_listener?(listener_name)
        listener_name = listener_name.to_s
        custom_listener_names.include?(listener_name) || custom_listener_name_aliases.stringify_keys.keys.include?(listener_name)
      end
      
      def custom_listener_names
        self.class.constants.include?(:CUSTOM_LISTENER_NAMES) ? self.class::CUSTOM_LISTENER_NAMES : []
      end
      
      def custom_listener_name_aliases
        self.class.constants.include?(:CUSTOM_LISTENER_NAME_ALIASES) ? self.class::CUSTOM_LISTENER_NAME_ALIASES : {}
      end
      
      def handle_custom_listener(listener_name, &listener)
        listener_name = listener_name.to_s
        listener_name = custom_listener_name_aliases.stringify_keys[listener_name] || listener_name
        instance_variable_name = "@#{listener_name}_procs" # TODO ensure clearing custom listeners on destroy of a control
        instance_variable_set(instance_variable_name, []) if instance_variable_get(instance_variable_name).nil?
        if listener.nil?
          instance_variable_get(instance_variable_name)
        else
          instance_variable_get(instance_variable_name) << listener
          listener
        end
      end
      
      def notify_custom_listeners(listener_name, *args)
        handle_custom_listener(listener_name).each do |listener|
          listener.call(*args)
        end
      end
      
      def deregister_custom_listeners(listener_name)
        handle_custom_listener(listener_name).clear
      end
      
      # deregisters all custom listeners except on_destroy, which can only be deregistered after destruction of a control, using deregister_custom_listeners
      def deregister_all_custom_listeners
        (custom_listener_names - ['on_destroy']).each { |listener_name| deregister_custom_listeners(listener_name) }
      end
      
      def respond_to?(method_name, *args, &block)
        @wx.respond_to?(method_name, true) ||
          can_handle_listener?(method_name.to_s) ||
          super(method_name, true)
      end
      
      def method_missing(method_name, *args, &block)
        if @wx.respond_to?(method_name, true)
          @wx.send(method_name, *args, &block)
        elsif can_handle_listener?(method_name.to_s)
          handle_listener(method_name.to_s, &block)
        else
          super
        end
      end
      
      def content(&block)
        Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Wx::ControlExpression.new, @keyword, {post_add_content: @content_added}, &block)
      end
      
      private
      
      def build_control
        # must pass control_proxy.wx as parent because the direct parent might be a sizer
        @wx = self.class.control_proxy_class(keyword).new_control(@keyword, control_proxy&.wx, @args)
      end
    end
  end
end

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
