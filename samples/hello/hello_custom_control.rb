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

Address = Struct.new(:full_name, :street, :street2, :city, :state, :zip_code, keyword_init: true) do
  def summary
    values.map(&:to_s).reject(&:empty?).join(', ')
  end
end

class AddressForm
  include Glimmer::Wx::CustomControl
  
  option :address
  
  body {
    Address.members.each do |attribute|
      attribute_human_name = attribute.to_s.split('_').map(&:capitalize).join(' ')
      h_box_sizer {
        sizer_args 0, Wx::DOWN, 10
        
        static_text(label: attribute_human_name) {
          sizer_args 0, Wx::RIGHT, 10
        }
        text_ctrl {
          sizer_args 0, Wx::RIGHT, 10
          value <=> [address, attribute]
        }
      }
    end
  }
end

shipping_address = Address.new
billing_address = Address.new

include Glimmer

frame(title: 'Hello, Custom Control!') { |window|
  panel {
    v_box_sizer {
      address_form(address: shipping_address)
      address_form(address: billing_address)
    }
  }
}
