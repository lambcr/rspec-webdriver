require 'rubygems'
require 'rspec/core'
require 'base64'
require 'fileutils'
require 'headless'
require File.expand_path(File.dirname(__FILE__) + "/rspec_extensions")
require File.expand_path(File.dirname(__FILE__) + "/reporting/selenium_test_report_formatter")

RSpec.configure do |config|

  config.before(:all) do
    @headless = Headless.new
    @headless.start
  end

  config.before(:each) do
    @headless.video.start_capture
  end

  config.after(:each) do 
    if actual_failure? 
      SeleniumTestReportFormatter.capture_system_state(@driver, @headless, self.example)
    else
      @headless.video.stop_and_discard
    end
  end

end

