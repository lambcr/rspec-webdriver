module Selenium
  module RSpec
    module Reporting
      
      class SystemCapture
        
        def initialize(selenium_driver, headless, example, file_path_strategy)
          @webdriver = selenium_driver
          @headless = headless
          @example = example
          @file_path_strategy = file_path_strategy 
        end
        
        def capture_system_state
          begin
            capture_html_snapshot
          rescue Exception => e
            STDERR.puts "WARNING: Could not capture HTML snapshot: #{e}"
          end
          begin
            capture_page_screenshot
          rescue Exception => e
            STDERR.puts "WARNING: Could not capture page screenshot: #{e}"
          end
          begin
            capture_video
          rescue Exception => e
            STDERR.puts "WARNING: Could not capture video: #{e}"
          end
        end

        def capture_html_snapshot
          html = @webdriver.page_source
          File.open(@file_path_strategy.file_path_for_html_capture(@example), "w") { |f| f.write html }
        end

        def capture_page_screenshot
          @webdriver.save_screenshot(@file_path_strategy.file_path_for_page_screenshot(@example))
        end

        def capture_video
          @headless.video.stop_and_save(@file_path_strategy.file_path_for_video(@example))
        end

      end
      
    end
  end
end
