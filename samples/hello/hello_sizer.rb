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

require 'glimmer-dsl-wx'

include Glimmer

frame { |main_frame|
  title 'Hello, Sizer!'
  
  h_box_sizer {
    v_box_sizer {
      sizer_args 0, Wx::RIGHT, 10
      
      button {
        sizer_args 0, Wx::DOWN, 10
        label 'Greeting 1'
        
        on_button do
          message_dialog(
            "Hello",
            "Greeting",
            Wx::OK | Wx::ICON_INFORMATION
          ).show_modal
        end
      }
  
      spacer(10)
      
      button {
        sizer_args 0, Wx::DOWN, 10
        label 'Greeting 2'
        
        on_button do
          message_dialog(
            "Howdy",
            "Greeting",
            Wx::OK | Wx::ICON_INFORMATION
          ).show_modal
        end
      }
  
      spacer(10)
      
      button {
        sizer_args 0, Wx::DOWN, 10
        label 'Greeting 3'
        
        on_button do
          message_dialog(
            "Hi",
            "Greeting",
            Wx::OK | Wx::ICON_INFORMATION
          ).show_modal
        end
      }
    }
    
    v_box_sizer {
      sizer_args 0, Wx::RIGHT, 10
      
      button {
        sizer_args 0, Wx::DOWN, 10
        label 'Greeting 4'
        
        on_button do
          message_dialog(
            "Ciao",
            "Greeting",
            Wx::OK | Wx::ICON_INFORMATION
          ).show_modal
        end
      }
  
      spacer(10)
      
      button {
        sizer_args 0, Wx::DOWN, 10
        label 'Greeting 5'
        
        on_button do
          message_dialog(
            "Aloha",
            "Greeting",
            Wx::OK | Wx::ICON_INFORMATION
          ).show_modal
        end
      }
  
      spacer(10)
      
      button {
        sizer_args 0, Wx::DOWN, 10
        label 'Greeting 6'
        
        on_button do
          message_dialog(
            "Salut",
            "Greeting",
            Wx::OK | Wx::ICON_INFORMATION
          ).show_modal
        end
      }
    }
  }
}
