require 'selenium-webdriver'
require 'interactor'

class SearchItem
  include Interactor

  def call
    puts 'SearchItem'

    sleep 4
    accept_alert_pop_up(context.driver, context.wait)
    open_search_bar(context.driver, context.wait)
    fill_form(context.driver, context.wait, context.search_str)
    submit_form(context.driver, context.wait)
  end

  private

  def fill_form(driver, wait, search_str)
    # Finding search input and writting our variable to it
    search_input = wait.until do
      driver.find_element(:css, '#input-search')
    end

    #clean_search_str = search_str.include?('-') ? search_str.split('-').first : search_str

    clean_search_str = if search_str == "Y-CAT"
      "CAT"
    elsif search_str.include?('-')
      search_str.split('-').first
    elsif search_str.include?('+')
      search_str.split('+').first
    else
      search_str
    end

    search_input.send_keys clean_search_str
  end

  def submit_form(driver, wait)
    # Clicking the form's submit button
    submit_button = wait.until do
      driver.find_element(:css, 'button[type="submit"]')
    end

    submit_button.click
  end

  def open_search_bar(driver, wait)
    search_bar_button = wait.until do
      driver.find_element(:css, 'div.MuiBox-root.css-1iox52a')
    end

    search_bar_button.click
  end

    def accept_alert_pop_up(driver, wait)
    return if driver.find_elements(:css, "button#axeptio_btn_acceptAll").none?

    button = driver.find_element(:css, "button#axeptio_btn_acceptAll")

    button.click
  end
end
