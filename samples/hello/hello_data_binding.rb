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

require 'glimmer-dsl-wx'

class Donor
  DONATION_AMOUNT_MIN = 0
  DONATION_AMOUNT_MAX = 100
  DONATION_AMOUNT_DEFAULT = 50
  
  attr_accessor :first_name, :last_name, :donation_amount
  
  def initialize
    @last_name = @first_name = ''
    @donation_amount = DONATION_AMOUNT_DEFAULT
  end
  
  def full_name
    full_name_parts = [first_name, last_name]
    full_name_string = full_name_parts.join(' ').strip
    if full_name_string.empty?
      'Anonymous'
    else
      full_name_string
    end
  end
  
  def summary
    "#{full_name} donated $#{donation_amount}"
  end
end

donor = Donor.new

include Glimmer

frame(title: 'Hello, Data-Binding!') { |window|
  panel {
    v_box_sizer {
      h_box_sizer {
        sizer_args 0, Wx::DOWN, 10
        
        static_text(label: 'First Name:') {
          sizer_args 0, Wx::RIGHT, 10
        }
        text_ctrl {
          sizer_args 0, Wx::RIGHT, 10
          # data-bind donor.first_name to text_ctrl.value bidirectionally,
          # ensuring changes to either attribute update the other attribute
          value <=> [donor, :first_name]
        }
      }
      
      h_box_sizer {
        sizer_args 0, Wx::DOWN, 10
        
        static_text(label: 'Last Name:') {
          sizer_args 0, Wx::RIGHT, 10
        }
        text_ctrl {
          sizer_args 0, Wx::RIGHT, 10
          # data-bind donor.last_name to text_ctrl.value bidirectionally,
          # ensuring changes to either attribute update the other attribute
          value <=> [donor, :last_name]
        }
      }
      
      h_box_sizer {
        sizer_args 0, Wx::DOWN, 10
        
        static_text(label: 'Donation Amount: $') {
          sizer_args 0, Wx::RIGHT, 1
        }
        spin_ctrl {
          sizer_args 0, Wx::RIGHT, 10
          range Donor::DONATION_AMOUNT_MIN, Donor::DONATION_AMOUNT_MAX
          # data-bind donor.donation_amount to spin_ctrl.value bidirectionally,
          # ensuring changes to either attribute update the other attribute
          value <=> [donor, :donation_amount]
        }
      }
      
      h_box_sizer {
        sizer_args 0, Wx::DOWN, 10
        
        slider {
          sizer_args 0, Wx::RIGHT, 10
          range Donor::DONATION_AMOUNT_MIN, Donor::DONATION_AMOUNT_MAX
          # data-bind donor.first_name to spinner.value bidirectionally,
          # ensuring changes to either attribute update the other attribute
          value <=> [donor, :donation_amount]
        }
      }
      
      h_box_sizer {
        sizer_args 0, Wx::DOWN, 10
        
        static_text(label: '') {
          sizer_args 0, Wx::RIGHT, 10
          # data-bind donor.summary to static_text.label unidirectionally,
          # with computed data-binding from donor summary dependencies: first_name, last_name, and donation_amount
          # ensuring changes to donor.summary or any of its dependencies update static_text.label
          label <= [donor, :summary, computed_by: [:first_name, :last_name, :donation_amount]]
        }
      }
    }
  }
}
