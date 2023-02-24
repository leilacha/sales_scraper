require 'selenium-webdriver'
require 'csv'
class CompanyUrlsFetcher

  def initialize(driver:, wait:)
    @driver = driver
    @wait = wait
  end

  def call
    puts 'CompanyUrlsFetcher'

    sleep 4
    close_popup
    close_cookies_alert

    list_elements.each do |list_element|
      url = list_element.find_element(:css, "a").attribute('href')
      company_name = list_element.find_element(:css, "h2").text

      row = [url, company_name]
      write_to_csv(row)
    end
  end

  private

  def write_to_csv(row)
    CSV.open("bepositive_company_urls.csv", "a") do |csv|
      csv << row
    end
  end

  def list_elements
    @driver.find_elements(:css, "ul#results-list li")
  end

  def close_popup
    return if @driver.find_elements(:css, "div.ub-emb-iframe-wrapper button.ub-emb-close").none?
    
    button = @driver.find_element(:css, "div.ub-emb-iframe-wrapper button.ub-emb-close")

    button.click
  end

  def close_cookies_alert
    begin
      return if @driver.find_elements(:css, "div#tarteaucitronAlertBig button#tarteaucitronAllDenied2").none?
      
      button = @driver.find_element(:css, "div#tarteaucitronAlertBig button#tarteaucitronAllDenied2")  

      button.click
    rescue
      true
    end
  end
end
