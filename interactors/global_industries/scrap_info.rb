require 'selenium-webdriver'
require 'interactor'
require 'csv'

class ScrapInfo
  include Interactor

  def call
    puts 'ScrapInfo'
    sleep 2

    info = fetch_info(context.driver, context.wait, context.search_str)

    puts info.join(', ')

    CSV.open("global_industries_result.csv", "a") do |csv|
      csv << info
    end
  end

  private

  def fetch_info(driver, wait, search_str)
    company_name = search_str
    current_url = driver.current_url
    activity = fetch_activity(driver, wait)
    contact_info = fetch_contact_info(driver, wait)

    [company_name, current_url, activity] + contact_info
  end

  def fetch_activity(driver, wait)
    if driver.find_elements(:xpath, "//div[text()='Description']/following-sibling::div").any?
      description = driver.find_element(:xpath, "//div[text()='Description']/following-sibling::div").text
    elsif driver.find_elements(:xpath, "//div[text()='Activités']/following-sibling::div").any?
      activities = driver.find_element(:xpath, "//div[text()='Activités']/following-sibling::div").text
    end

    [description&.gsub("\n", "-"), activities&.gsub("\n", "-")].compact.join(' - ')
  end

  def fetch_contact_info(driver, wait)
    contacts = driver.find_elements(:css, 'span.gooLuw')
    contacts.map(&:text)
  end
end
