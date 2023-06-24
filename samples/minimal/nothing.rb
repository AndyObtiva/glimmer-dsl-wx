#!/usr/bin/env ruby
# wxRuby2 Sample Code. Copyright (c) 2004-2008 wxRuby development team
# Adapted for wxRuby3
# Copyright (c) M.J.N. Corino, The Netherlands
###
 
# require 'wx'

# This is the minimum code to start a WxRuby app - create a Frame, and
# show it.
# Wx::App.run do
###     self.app_name = 'Nothing'
###     frame = Wx::Frame.new(nil, title: "Empty wxRuby App")
#   frame = Wx::Frame.new(nil)
#   frame.title = "Empty wxRuby App"
#   frame.show
#   frame
# end

require './lib/glimmer-dsl-wx'

include Glimmer

frame {
  title "Empty wxRuby App"
}
