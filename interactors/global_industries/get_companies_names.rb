require 'selenium-webdriver'
require 'interactor'
require 'pry'

class GetCompaniesNames
  include Interactor

  def call
    load_whole_page(context.driver)
    print_titles(context.driver, context.wait)
  end

  private

  def print_titles(driver, wait)
    sleep(5)
    titles = wait.until do
      driver.find_elements(:css, 'div.grid__Grid-sc-0-8 span:first-child')
    end

    File.open("global_industries_companies_name_test.txt", "w+") do |f|
      titles.each { |element| f.puts(element.text) }
    end
  end

  def load_whole_page(driver)
    # auto scroll didn't work - I scrolled manually instead

    # counter = 1
    # scroll_pause_time = 2
    # screen_height = driver.execute_script("return window.screen.height;")
    # not_the_end = true

    # while not_the_end
    #   sleep(scroll_pause_time)
    #   scroll_height = driver.execute_script("return document.body.scrollHeight;")
    #   counter += 1
    #   not_the_end = screen_height * counter < scroll_height
    # end
  end
end
