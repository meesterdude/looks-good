require 'capybara'
require 'capybara/dsl'
require 'gatling'

Capybara.default_driver = :selenium
Capybara.app_host = 'http://www.google.com'
