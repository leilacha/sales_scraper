require 'selenium-webdriver'
require 'interactor'

class SelectItem
  include Interactor

  def call
    puts 'SelectItem'
    sleep 2
    
    accept_alert_pop_up(context.driver, context.wait)
    select_result(context.driver, context.wait, context.search_str)
  end

  private

  def select_result(driver, wait, search_str)
    # Find and click on company name in results page
    search_results = driver.find_elements(:css, "a div.css-1s3wwkk")

    search_result = search_results.find { |result| result.text == search_str }
    
    raise "Error: not the right result - #{search_str}" unless search_result

    search_result.click 
  end

  def accept_alert_pop_up(driver, wait)
    return if driver.find_elements(:css, "button#axeptio_btn_acceptAll").none?

    button = driver.find_element(:css, "button#axeptio_btn_acceptAll")

    button.click
  end
end
