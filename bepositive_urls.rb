require 'selenium-webdriver'
require 'interactor'
require 'pry'
require_relative 'interactors/bepositive/company_urls_fetcher'

class BepositiveUrls
  def initialize
    # Initilize the driver with our desired browser
    @driver = Selenium::WebDriver.for :chrome

    # Define global timeout threshold
    @wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
  end

  def scrape
    (1..74).map(&:to_s).each do |page|
      @driver.get "https://www.bepositive-events.com/fr/liste-exposants?page=#{page}"

      get_company_urls(page)
    end

    @driver.quit
  end

  private

  def get_company_urls(page)
    CompanyUrlsFetcher.new(
      driver: @driver,
      wait: @wait
    ).call
  end

end

# Run program
BepositiveUrls.new.scrape
