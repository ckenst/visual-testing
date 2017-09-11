require 'eyes_selenium'
require 'selenium-webdriver'

# Initialize the eyes SDK and set your private API key.
eyes = Applitools::Selenium::Eyes.new
eyes.api_key = ENV['APPLITOOL_KEY']

# Opens a browser in Chrome.
web_driver = Selenium::WebDriver.for :chrome


begin
  # Start the test and set the browser's viewport size to 800x600.
  eyes.test(app_name: 'Hello World!', test_name: 'My first Selenium Ruby test!',
            viewport_size: {width:800, height:600}, driver: web_driver) do |driver|

    # Navigate the browser to the "hello world!" web-site.
    driver.get 'https://applitools.com/helloworld'

    # Visual checkpoint #1.
    eyes.check_window 'Hello!'

    # Click the "Click me!".
    driver.find_element(:tag_name => 'button').click

    # Visual checkpoint #2.
    eyes.check_window 'Click!'

    # End the test.
    eyes.close
  end
ensure
  # Close the browser.
  web_driver.quit

  # If the test was aborted before eyes.close was called, ends the test as aborted.
  eyes.abort_if_not_closed
end
