# Change Log

## 0.1.0

- Upgrade to wxruby3 1.0.0
- Upgrade to glimmer 2.7.7
- Support control operations (methods) in the DSL
- Improve detection of property setter methods on controls when invoking from DSL
- Support property unidirectional data-binding for all controls
- Support property bidirectional data-binding for text_ctrl
- Support property bidirectional data-binding for spin_ctrl
- Support property bidirectional data-binding for spin_ctrl_double
- Support property bidirectional data-binding for slider
- Hello, Data-Binding! Sample

## 0.0.7

- Sizer addable support (e.g. supporting `growable_col(1, 1)`, using `add_growable_col(1, 1)` method in wxruby3 API)
- Ability to nest sizers within sizers
- Update samples/hello/hello_sizer.rb to use a `spacer` addable and nest `v_box_sizer` under `h_box_sizer`

## 0.0.6

- Sizer (layout) support
- samples/hello/hello_sizer.rb
- Refactor/move `glimmer_new` samples to `hello` directory
- Fix `ControlProxy#frame_proxy` method, which grabs the parent frame (going all the way to the top of the hierarchy)

## 0.0.5

- Nested child control support
- Listener support
- `about_box` keyword for displaying an about dialog box
- samples/glimmer_new/hello_button.rb
- samples/glimmer_new/hello_button2.rb
- Fix again the issue with complaining about not finding `frame` `app_name` when not specified despite it being optional

## 0.0.4

- Fix issue with complaining about not finding `frame` `app_name` when not specified despite it being optional

## 0.0.3

- Support control arguments and properties
- girb (Glimmer IRB)
- Use frame title argument in samples/minimal/nothing.rb
- Support `app_name` argument/property on `frame`
- Automatically set `app_name` to `frame` `title` if `frame` `app_name` is not specified
- samples/glimmer_new/hello_world.rb
- samples/glimmer_new/hello_world2.rb

## 0.0.2

- Remove forgotten occurrences of pd (puts_debuggerer) from code

## 0.0.1

- First alpha release of Glimmer DSL for WX for wxWidgets GUI Toolkit, using wxruby3 binding, and supporting "nothing" sample
