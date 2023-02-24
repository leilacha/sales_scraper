require 'selenium-webdriver'
require 'interactor'
require 'pry'
require_relative 'interactors/bepositive/info_scraper'

class BepositiveScraper
  def initialize
    # Initilize the driver with our desired browser
    @driver = Selenium::WebDriver.for :chrome

    # Define global timeout threshold
    @wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
  end

  def scrape
    companies_urls_and_names = CSV.read("bepositive_company_urls.csv")

    companies_urls_and_names.each_with_index do |company_url_name, index|
      next if index < result_index

      url = company_url_name.first
      company_name = company_url_name.last
      puts "START: #{index} - #{company_name}"

      @driver.get url

      InfoScraper.new(
        driver: @driver,
        wait: @wait,
        url: url,
        company_name: company_name
      ).call
      puts "SUCCESS"
    end

    @driver.quit
  end

  def result_index
    result_path = 'bepositive_info.csv'
    result_file = CSV.read(result_path)

    result_file.count
  end
end

# Run program
BepositiveScraper.new.scrape
