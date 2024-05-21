# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for WX 0.1.0
## wxWidgets Ruby Desktop Development GUI Library
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-wx.svg)](https://badge.fury.io/rb/glimmer-dsl-wx)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Glimmer](https://github.com/AndyObtiva/glimmer) DSL for [WX](https://www.wxwidgets.org/) is an [MRI Ruby](https://www.ruby-lang.org) desktop development GUI (Graphical User Interface) library for the cross-platform native widget [wxWidgets](https://www.wxwidgets.org/) GUI toolkit. It provides a Glimmer GUI DSL on top of the [wxruby3](https://github.com/mcorino/wxRuby3) binding.

![Hello, Data-Binding!](/screenshots/glimmer-dsl-wx-sample-hello-data-binding.gif?raw=true)

[Glimmer DSL for WX](https://rubygems.org/gems/glimmer-dsl-wx) aims to provide a DSL similar to the [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) to enable more productive desktop development in Ruby with:
- [Declarative DSL syntax](#glimmer-gui-dsl-concepts) that visually maps to the GUI control hierarchy
- [Convention over configuration](#smart-defaults-and-conventions) via smart defaults and automation of low-level details
- Requiring the [least amount of syntax](#glimmer-gui-dsl-concepts) possible to build GUI
- [Custom Control](#custom-keywords) support
- [Bidirectional/Unidirectional Data-Binding](#data-binding) to declaratively wire and automatically synchronize GUI Views with Models
- Scaffolding for new custom controls, apps, and gems
- Native-Executable packaging on Mac, Windows, and Linux.

**Hello, World!**

```ruby
require 'glimmer-dsl-wx'

include Glimmer

frame(title: 'Hello, World!')
```

![Hello, World!](/screenshots/glimmer-dsl-wx-sample-hello-world.png?raw=true)

**Hello Button!**

```ruby
require 'glimmer-dsl-wx'

include Glimmer

frame { |main_frame|
  title 'Hello, Button!'
  
  h_box_sizer {
    button {
      sizer_args 0, Wx::RIGHT, 10
      label 'Click To Find Who Built This!'
      
      on_button do
        about_box(
          name: main_frame.title,
          version: Wx::WXRUBY_VERSION,
          description: "This is the Hello, Button! sample",
          developers: ['The Glimmer DSL for WX Development Team']
        )
      end
    }
  }
}
```

![Hello, Button!](/screenshots/glimmer-dsl-wx-sample-hello-button.png?raw=true)

![Hello, Button! Clicked](/screenshots/glimmer-dsl-wx-sample-hello-button-clicked.png?raw=true)

Learn more about the differences between various [Glimmer](https://github.com/AndyObtiva/glimmer) DSLs by looking at the **[Glimmer DSL Comparison Table](https://github.com/AndyObtiva/glimmer#glimmer-dsl-comparison-table)**.

## Table of Contents

- [Glimmer DSL for WX](#)
  - [Setup](#setup)
  - [Usage](#usage)
  - [GIRB (Glimmer IRB)](#girb-glimmer-irb)
  - [Smart Defaults and Conventions](#smart-defaults-and-conventions)
  - [Samples](#samples)
    - [Hello, World!](#hello-world)
    - [Hello, Button!](#hello-button)
    - [Hello, Sizer!](#hello-sizer)
    - [Hello, Data-Binding!](#hello-data-binding)
  - [Coming From wxruby3](#coming-from-wxruby3)
  - [Process](#process)
  - [Resources](#resources)
  - [Help](#help)
    - [Issues](#issues)
    - [Chat](#chat)
  - [Planned Features and Feature Suggestions](#planned-features-and-feature-suggestions)
  - [Change Log](#change-log)
  - [Contributing](#contributing)
  - [Contributors](#contributors)
  - [License](#license)

## Setup

Follow instructions for installing [wxruby3](https://github.com/mcorino/wxRuby3) on a supported platform (Linux or Windows):
https://github.com/mcorino/wxRuby3/blob/master/INSTALL.md

Install [glimmer-dsl-wx](https://rubygems.org/gems/glimmer-dsl-wx) gem directly into a [maintained Ruby version](https://www.ruby-lang.org/en/downloads/):

```
gem install glimmer-dsl-wx
```
 
Or install via Bundler `Gemfile`:

```ruby
gem 'glimmer-dsl-wx', '~> 0.1.0'
```

Test that installation worked by running a sample:

```
ruby -r glimmer-dsl-wx -e "require 'samples/hello/hello_world'"
```

If you cloned project, test by running a sample locally:

```
ruby -r ./lib/glimmer-dsl-wx.rb samples/hello/hello_world.rb
```

## Usage

To use [glimmer-dsl-wx](https://rubygems.org/gems/glimmer-dsl-wx):
1. Add `require 'glimmer-dsl-wx'` at the top of the Ruby file (this will automatically `require 'wxruby3'` too)
2. Add `include Glimmer` into the top-level main object for testing or into an actual class for serious application usage.
3. Write GUI DSL code beginning with `frame` to build a window first and then nest other controls/sizers within it.

Example:

```ruby
require 'glimmer-dsl-wx'

include Glimmer

frame { |main_frame|
  title 'Hello, Button!'
  
  h_box_sizer {
    button {
      sizer_args 0, Wx::RIGHT, 10
      label 'Click To Find Who Built This!'
      
      on_button do
        message_dialog(
          "The Glimmer DSL for WX Team",
          "Greeting",
          Wx::OK | Wx::ICON_INFORMATION
        ).show_modal
      end
    }
  }
}
```

![Hello, Button!](/screenshots/glimmer-dsl-wx-sample-hello-button.png?raw=true)

Glimmer DSL for WX follows these simple concepts in mapping from wxruby3 syntax to Glimmer GUI DSL syntax:

**Keyword(args)**: wxruby3 controls/sizers may be declared by lower-case underscored name. For example, `Frame` becomes `frame`. `HBoxSizer` becomes `h_box_sizer`. And, they receive the same arguments as the wxruby3 class constructor. For example, `Frame.new(title: 'Hello')` becomes `frame(title: 'Hello')`.

**Content Block** (Properties/Listeners/Controls): Any keyword may be optionally followed by a declarative Ruby curly-brace multi-line content block containing properties (attributes), listeners, and/or nested controls/sizers.

Example:

```ruby
frame(title: 'Hello, Button') {
  h_box_sizer {
    button(label: 'Click To Find Who Built This!')
  }
}
```

Content block optionally receives one arg representing the control or sizer it represents.

Example:

```ruby
frame(title: 'Hello, Button!') { |main_frame|
  h_box_sizer {
    button {
      sizer_args 0, Wx::RIGHT, 10
      label 'Click To Find Who Built This!'
      
      on_button do
        about_box(
          name: main_frame.title,
          version: Wx::WXRUBY_VERSION,
          description: "This is the Hello, Button! sample",
          developers: ['The Glimmer DSL for WX Development Team']
        )
      end
    }
  }
}
```

**Property**: Control properties may be declared inside keyword blocks with lower-case underscored name followed by property value args (e.g. `title "Hello"` inside `frame`). Behind the scenes, properties correspond to `control.property=` methods like `frame.title=`.

Controls and sizers (objects that organize controls within certain layouts) could accept a special `sizer_args` property, which takes the arguments normally passed to the `sizer.add` method. For example, `sizer_args 0, Wx::RIGHT, 10` translates to `sizer.add(control, 0, Wx::Right, 10)` behind the scenes.

**Listener**: Control listeners may be declared inside keyword blocks with listener lower-case underscored name beginning with `on_` followed by event name (translates to `frame.evt_#{event_name}` like `frame.evt_button` for the click of a button) and receiving required block handler (always followed by a `do; end` style block to signify imperative Model logic vs declarative View control/sizer nesting).

Example:

```ruby
button('click') {
  on_clicked do
    puts 'clicked'
  end
}
```

Optionally, the listener block can receive an arg representing the control.

```ruby
...
    button {
      sizer_args 0, Wx::RIGHT, 10
      label 'Click To Find Who Built This!'
      
      on_button do
        # Do work!
      end
    }
...
```

Behind the scenes, listeners correspond to `frame.evt_#{event_name}` methods. So, for `on_button`, the event name is `button`, and that translates to `frame.evt_button(button, &listener)` behind the scenes.

**Operation**: Controls have methods that invoke certain operations on them. For example, `message_dialog` has a `#show_modal` method that shows the message dialog GUI.

```ruby
...
        message_dialog(
          "The Glimmer DSL for WX Team",
          "Greeting",
          Wx::OK | Wx::ICON_INFORMATION
        ).show_modal
...
```

## GIRB (Glimmer IRB)

You can run the `girb` command (`bin/girb` if you cloned the project locally) to do some quick and dirty experimentation and learning:

```
girb
```

This gives you `irb` with the `glimmer-dsl-wx` gem loaded and the `Glimmer` module mixed into the main object for easy experimentation with GUI.

## Smart Defaults and Conventions

- Instantiate any wxWidgets control or sizer by using its underscored name (e.g. `Button` becomes `button`)
- `frame` will automatically execute within a `Wx::App.run` block and `show` the Frame

## Samples

### Hello, World!

![Hello, World!](/screenshots/glimmer-dsl-wx-sample-hello-world.png?raw=true)

```ruby
require 'glimmer-dsl-wx'

include Glimmer

frame(title: 'Hello, World!')
```

Alternate Syntax:

```ruby
require 'glimmer-dsl-wx'

include Glimmer

frame {
  title 'Hello, World!'
}
```

### Hello Button!

![Hello, Button!](/screenshots/glimmer-dsl-wx-sample-hello-button.png?raw=true)

![Hello, Button! Clicked](/screenshots/glimmer-dsl-wx-sample-hello-button-clicked.png?raw=true)

```ruby
require 'glimmer-dsl-wx'

include Glimmer

frame(title: 'Hello, Button!') { |main_frame|
  h_box_sizer {
    button(label: 'Click To Find Who Built This!') {
      sizer_args 0, Wx::RIGHT, 10
      
      on_button do
        about_box(
          name: main_frame.title,
          version: Wx::WXRUBY_VERSION,
          description: "This is the Hello, Button! sample",
          developers: ['The Glimmer DSL for WX Development Team']
        )
      end
    }
  }
}
```

Alternate Syntax:

```ruby
require 'glimmer-dsl-wx'

include Glimmer

frame { |main_frame|
  title 'Hello, Button!'
  
  h_box_sizer {
    button {
      sizer_args 0, Wx::RIGHT, 10
      label 'Click To Find Who Built This!'
      
      on_button do
        about_box(
          name: main_frame.title,
          version: Wx::WXRUBY_VERSION,
          description: "This is the Hello, Button! sample",
          developers: ['The Glimmer DSL for WX Development Team']
        )
      end
    }
  }
}
```

### Hello Sizer!

![Hello, Sizer!](/screenshots/glimmer-dsl-wx-sample-hello-sizer.png?raw=true)

![Hello, Sizer! Clicked](/screenshots/glimmer-dsl-wx-sample-hello-sizer-clicked.png?raw=true)

```ruby
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
            "Greeting 1",
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
            "Greeting 2",
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
            "Greeting 3",
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
            "Greeting 4",
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
            "Greeting 5",
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
            "Greeting 6",
            Wx::OK | Wx::ICON_INFORMATION
          ).show_modal
        end
      }
    }
  }
}
```

### Hello Data-Binding!

Glimmer DSL for WX supports data-binding via `<=` for unidirectional data-binding and `<=>` for bidirectional data-binding.

![Hello, Data-Binding!](/screenshots/glimmer-dsl-wx-sample-hello-data-binding.gif?raw=true)

```ruby
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
```

## Coming From wxruby3

If you would like to translate wxruby3 code into Glimmer DSL for WX code, read the [Usage](#usage) section to understand how Glimmer GUI DSL syntax works, and then check out the example below, which is written in both wxruby3 and Glimmer DSL for WX.

Example written in wxruby3:

```ruby
require 'wx'

class TheFrame < Wx::Frame
  def initialize(title)
    super(nil, title: title)
    panel = Wx::Panel.new(self)
    button = Wx::Button.new(panel, label: 'Click me')
    button.evt_button(Wx::ID_ANY) { Wx.message_box('Hello. Thanks for clicking me!', 'Hello Button sample') }
  end
end

Wx::App.run { TheFrame.new('Hello world!').show }
```

![Hello_Button](https://raw.githubusercontent.com/mcorino/wxRuby3/master/assets/hello_button.png)
![Hello_Button_Clicked](https://raw.githubusercontent.com/mcorino/wxRuby3/master/assets/hello_button_clicked.png)

Example re-written in Glimmer DSL for WX:

```ruby
require 'glimmer-dsl-wx'

include Glimmer

frame(title: 'Hello world!') {
  panel {
    button(label: 'Click me') {
      on_button do
        Wx.message_box('Hello. Thanks for clicking me!', 'Hello Button sample')
      end
    }
  }
}
```

![Hello_Button](https://raw.githubusercontent.com/mcorino/wxRuby3/master/assets/hello_button.png)
![Hello_Button_Clicked](https://raw.githubusercontent.com/mcorino/wxRuby3/master/assets/hello_button_clicked.png)

## Process

[Glimmer Process](https://github.com/AndyObtiva/glimmer/blob/master/PROCESS.md)

## Resources

- [Code Master Blog](https://andymaleh.blogspot.com)
- [wxruby3 Bindings](https://github.com/mcorino/wxRuby3) (used by Glimmer DSL for WX)
- [wxWidgets GUI Toolkit](https://www.wxwidgets.org/) (used by Glimmer DSL for WX)
- [wxWidgets Controls](https://docs.wxwidgets.org/3.0/group__group__class__ctrl.html)
- [wxWidgets Sizers](https://docs.wxwidgets.org/3.0/overview_sizer.html)

## Help

### Issues

If you encounter [issues](https://github.com/AndyObtiva/glimmer-dsl-wx/issues) that are not reported, discover missing features that are not mentioned in [TODO.md](TODO.md), or think up better ways to use [wxWidgets](https://www.wxwidgets.org/) than what is possible with [Glimmer DSL for WX](https://rubygems.org/gems/glimmer-dsl-wx), you may submit an [issue](https://github.com/AndyObtiva/glimmer-dsl-wx/issues/new) or [pull request](https://github.com/AndyObtiva/glimmer-dsl-wx/compare) on [GitHub](https://github.com). In the meantime, you may try older gem versions of [Glimmer DSL for WX](https://rubygems.org/gems/glimmer-dsl-wx) till you find one that works.

### Chat

If you need live help, try to [![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Planned Features and Feature Suggestions

These features have been planned or suggested. You might see them in a future version of [Glimmer DSL for WX](https://rubygems.org/gems/glimmer-dsl-wx). You are welcome to contribute more feature suggestions.

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Contributing

If you would like to contribute to the project, please adhere to the [Open-Source Etiquette](https://github.com/AndyObtiva/open-source-etiquette) to ensure the best results.

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

Note that the latest development sometimes takes place in the [development](https://github.com/AndyObtiva/glimmer-dsl-wx/tree/development) branch (usually deleted once merged back to [master](https://github.com/AndyObtiva/glimmer-dsl-wx)).

## Contributors

* [Andy Maleh](https://github.com/AndyObtiva) (Founder)

[Click here to view contributor commits.](https://github.com/AndyObtiva/glimmer-dsl-wx/graphs/contributors)

## License

[MIT](LICENSE.txt)

Copyright (c) 2023-2024 Andy Maleh

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built for [Glimmer](https://github.com/AndyObtiva/glimmer) (DSL Framework).
