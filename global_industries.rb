require 'selenium-webdriver'
require 'interactor'
require 'pry'
require_relative 'interactors/global_industries/scraping_organizer'

class GlobalIndustries
  def initialize
    # Initilize the driver with our desired browser
    @driver = Selenium::WebDriver.for :chrome

    init_driver
  end

  def scrape
    file = File.open("interactors/global_industries/companies_names.txt").read
    companies_names = file.split("\n")

    companies_names.each_with_index do |company_name, index|
      next if index < result_index
      trial_count = 0

      scrape_for(company_name, index, trial_count)
    end
    @driver.quit
  end

  private

  def scrape_for(company_name, index, trial_count)
    raise "Error!" if trial_count == 3
    begin
      puts "START: #{index} - #{company_name}"

      ScrapingOrganizer.call(
        driver: @driver,
        wait: @wait,
        search_str: company_name
      )

      puts "SUCCESS"
    rescue
       sleep(6)
       init_driver
       puts "RETRY: #{index} - #{company_name}"
       scrape_for(company_name, index, trial_count + 1)
    end
  end

  def result_index
    result_path = 'global_industries_result.csv'
    result_file = File.open(result_path).read
    
    result_file.split("\n").count - 1
  end

  def init_driver
    @driver.get 'https://global-industrie.com/fr/liste-des-exposants'

    # Define global timeout threshold
    @wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
  end
end

# Run program
GlobalIndustries.new.scrape
