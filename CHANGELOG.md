# Change Log

## 0.0.6

- Sizer (layout) support
- samples/glimmer_new/hello_sizer.rb
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
