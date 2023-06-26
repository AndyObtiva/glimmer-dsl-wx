# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for WX 0.0.7
## wxWidgets Ruby Desktop Development GUI Library
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-wx.svg)](https://badge.fury.io/rb/glimmer-dsl-wx)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Glimmer](https://github.com/AndyObtiva/glimmer) DSL for [WX](https://www.wxwidgets.org/) is an [MRI Ruby](https://www.ruby-lang.org) desktop development GUI (Graphical User Interface) library for the cross-platform native widget [wxWidgets](https://www.wxwidgets.org/) GUI toolkit. It provides a Glimmer GUI DSL on top of the [wxruby3](https://github.com/mcorino/wxRuby3) binding.

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

![Hello, World!](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-world.png?raw=true)

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

![Hello, Button!](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-button.png?raw=true)

![Hello, Button! Clicked](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-button-clicked.png?raw=true)

**[Glimmer](https://rubygems.org/gems/glimmer) DSL Comparison Table:**
DSL | Platforms | Native? | Vector Graphics? | Pros | Cons | Prereqs
----|-----------|---------|------------------|------|------|--------
[Glimmer DSL for SWT (JRuby Desktop Development GUI Framework)](https://github.com/AndyObtiva/glimmer-dsl-swt) | Mac / Windows / Linux | Yes | Yes (Canvas Shape DSL) | Very Mature / Scaffolding / Native Executable Packaging / Custom Widgets | Slow JRuby Startup Time / Heavy Memory Footprint | Java / JRuby
[Glimmer DSL for Opal (Pure Ruby Web GUI and Auto-Webifier of Desktop Apps)](https://github.com/AndyObtiva/glimmer-dsl-opal) | All Web Browsers | No | Yes (Canvas Shape DSL) | Simpler than All JavaScript Technologies / Auto-Webify Desktop Apps | Setup Process / Only Rails 5 Support for Now | Rails
[Glimmer DSL for LibUI (Prerequisite-Free Ruby Desktop Development GUI Library)](https://github.com/AndyObtiva/glimmer-dsl-libui) | Mac / Windows / Linux | Yes | Yes (Area API) | Fast Startup Time / Light Memory Footprint | LibUI is an Incomplete Mid-Alpha Only | None Other Than MRI Ruby
[Glimmer DSL for Tk (Ruby Tk Desktop Development GUI Library)](https://github.com/AndyObtiva/glimmer-dsl-tk) | Mac / Windows / Linux | Some Native-Themed Widgets (Not Truly Native) | Yes (Canvas) | Fast Startup Time / Light Memory Footprint | Complicated Setup / Widgets Do Not Look Truly Native, Espcially on Linux | ActiveTcl / MRI Ruby
[Glimmer DSL for GTK (Ruby-GNOME Desktop Development GUI Library)](https://github.com/AndyObtiva/glimmer-dsl-gtk) | Mac / Windows / Linux | Only on Linux | Yes (Cairo) | Complete Access to GNOME Features on Linux (Forte) | Not Native on Mac and Windows | None Other Than MRI Ruby on Linux / Brew Packages on Mac / MSYS & MING Toolchains on Windows / MRI Ruby
[Glimmer DSL for FX (FOX Toolkit Ruby Desktop Development GUI Library)](https://github.com/AndyObtiva/glimmer-dsl-fx) | Mac (requires XQuartz) / Windows / Linux | No | Yes (Canvas) | No Prerequisites on Windows (Forte Since Binaries Are Included Out of The Box) | Widgets Do Not Look Native / Mac Usage Obtrusively Starts XQuartz | None Other Than MRI Ruby on Windows / XQuarts on Mac / MRI Ruby
[Glimmer DSL for WX (wxWidgets Ruby Desktop Development GUI Library)](https://github.com/AndyObtiva/glimmer-dsl-wx) | Mac / Windows / Linux | Yes | Yes | Fast Startup Time / Light Memory Footprint | wxruby3 is still beta and does not support Mac yet | wxWidgets library, Doxygen, and other prereqs
[Glimmer DSL for JFX (JRuby JavaFX Desktop Development GUI Library)](https://github.com/AndyObtiva/glimmer-dsl-jfx) | Mac / Windows / Linux | No | Yes (javafx.scene.shape and javafx.scene.canvas) | Rich in Custom Widgets | Slow JRuby Startup Time / Heavy Memory Footprint / Widgets Do Not Look Native | Java / JRuby / JavaFX SDK
[Glimmer DSL for Swing (JRuby Swing Desktop Development GUI Library)](https://github.com/AndyObtiva/glimmer-dsl-swing) | Mac / Windows / Linux | No | Yes (Java2D) | Very Mature | Slow JRuby Startup Time / Heavy Memory Footprint / Widgets Do Not Look Native | Java / JRuby
[Glimmer DSL for XML (& HTML)](https://github.com/AndyObtiva/glimmer-dsl-xml) | All Web Browsers | No | Yes (SVG) | Programmable / Lighter-weight Than Actual XML | XML Elements Are Sometimes Not Well-Named (Many Types of Input) | None
[Glimmer DSL for CSS](https://github.com/AndyObtiva/glimmer-dsl-css) | All Web Browsers | No | Yes | Programmable | CSS Is Over-Engineered / Too Many Features To Learn | None

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
gem 'glimmer-dsl-wx', '~> 0.0.7'
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
1. Add `require 'glimmer-dsl-wx'` at the top of the Ruby file.
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

![Hello, Button!](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-button.png?raw=true)

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

![Hello, World!](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-world.png?raw=true)

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

![Hello, Button!](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-button.png?raw=true)

![Hello, Button! Clicked](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-button-clicked.png?raw=true)

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

![Hello, Sizer!](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-sizer.png?raw=true)

![Hello, Sizer! Clicked](https://github.com/AndyObtiva/glimmer-dsl-wx/blob/master/screenshots/glimmer-dsl-wx-sample-hello-sizer-clicked.png?raw=true)

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
```

## Process

[Glimmer Process](https://github.com/AndyObtiva/glimmer/blob/master/PROCESS.md)

## Resources

- [Code Master Blog](https://andymaleh.blogspot.com)
- [wxruby3 Bindings](https://github.com/mcorino/wxRuby3)
- [wxWidgets GUI Toolkit](https://www.wxwidgets.org/)

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

Copyright (c) 2023 Andy Maleh

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built for [Glimmer](https://github.com/AndyObtiva/glimmer) (DSL Framework).
