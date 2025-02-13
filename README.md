# LooksGood

A visual RSpec matcher to ensure the entire page (or specific elements) have not changed. Allows for a tolerance to be set, so you can reuire pixel-perfect or allow for some minor changes. 

-------------------------------------

## Installation:

        gem install looks_good

In rails_helper.rb:

        require 'looks_good'
        require 'looks_good/matchers/look_like_matcher'

add to your `.gitignore`

        spec/screenshots/tmp/*

### Usage:

Identify an element to match, for example:

        @element = page.find(:css, 'main')

Use LooksGood's custom matcher and specify the reference image:
        
        expect(@element).to look_like(:main_section)

LooksGood will take care of cropping the element and try and make a targeted match without the noise of the whole page. 
The parameter passed to `look_like` is the name that will be used to store the initial screenshot, and will be used in subsequent comparisons. 

`look_like` can also handle the file naming and storage, if you specify a symbol. If the above example is from the spec `system/frontend/login_spec.rb`, then the screenshot will be stored in `spec/screenshots/system/frontend/login/main_section.png`. 

You can ovveride this automatic behavior by specifying the file path as a string. 

        expect(@element).to look_like("frontend/main-screen.png")

which would store the screenshot in `spec/screenshots/frontend/main-screen.png`

If you want to adjust how tolerant the matcher is of differences, specify a float between 0 and 1 to `within`

        expect(@element).to look_like(:main_content, within: 0.05)

If no reference image exits, the test will pass and a reference file will be created for future comparisons.

If you encounter a failure for a desired change, a diff image will be created to visualze the differences as well as a reference to the new version. 
you can either copy the file provided in the error, or run your test suite again with `LOOKS_GOOD=true` to update it to the new version. 


-------------------------------------

### Configuration settings:

you can override any of the defaults with a config block. 

#### Configuration settings are set with the following:

          LooksGood.config do |c|
            c.reference_image_path = 'spec/screenshots'
            c.max_no_tries = 1
            c.default_within = 0.01
            c.sleep_between_tries = 0.5
            c.browser_folders = false
            c.scale_amount = 0.5
            c.disable_scling = true
            c.fuzz = "10%"
          end


#### reference_image_path - sets where the reference and diff images are saved to.

For Rails application, a default images folder will be created at spec/screenshots. This folder is root to all the reference
images to be compares, but can be changed. 

Also created are subfolders:
- tmp/ - will hold temporary/transient images. add this to .gitignore. 
- tmp/candidate/  - will hold candidate images which can be used as the new versions of reference images
- tmp/diff/ - will hold the visual diff images for inspection when comparison fails

#### max_no_tries 
- sets how many times looks_good will try and match the element against the reference image. Handy to reduce fragility of tests due to animations and load times. Defaults to 2.

#### default_within
- a float between 0 and 1 that sets the default tolerance for visual differences. default is 0.0001, which is strict but not absolute 0. Larger screenshots will be less sensitive to subtle differences as a percentage. 

#### fuzz
- allows pixels to not need to match exactly. a string percentage value, provided to imagemagick as fuzz value for comparison. default is "10%"

#### scale_amount
- Retina mac screenshots are 2x actual size, so this scales them to be 1:1. default is 0.5.

#### disable_scaling
set to true to disable the scaling behavior

#### custom_error_message
When the spec fails, this message will be appended to the failure. 

#### Sleep_between_tries 
- sets the sleep time (in seconds) between match tries (requires max_no_tries > 1). Defaults to 0.5

#### browser_folders 
- *Currently only available with Selenium-Webdriver / Capybara* - create reference folders based on the current Selenium driver's browser. Allows for cross-browser visual testing.


-------------------------------------

#### Non-gem dependencies:

Imagemagick must be installed:

  $sudo apt-get install imagemagick

-------------------------------------


## Contributing to `looks_good`

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== History
looks_good is an expansion of (gatling)[https://github.com/gabrielrotbart/gatling] with added functionality and updated dependecies.

== Copyright

Copyright (c) 2022 Russell Jennings See LICENSE.txt for
further details.

