require 'selenium-webdriver'
require 'csv'
class InfoScraper

  def initialize(driver:, wait:, url:, company_name:)
    @driver = driver
    @wait = wait
    @url = url
    @company_name = company_name
  end

  def call
    puts 'InfoScraper'

    sleep 4
    close_popup
    close_cookies_alert

    website = fetch_website
    phone = fetch_phone
    address = fetch_address
    description = fetch_description
    activity = fetch_activity

    row = [@company_name, @url, website, phone, address, description, activity]
    write_to_csv(row)
  end

  private

  def write_to_csv(row)
    puts row

    CSV.open("bepositive_info.csv", "a") do |csv|
      csv << row
    end
  end

  def fetch_website
    return '' unless @driver.find_elements(:xpath, "//a[text()='Visiter le site web']").any?

    website_button = @driver.find_element(:xpath, "//a[text()='Visiter le site web']")

    website_button.attribute('href')
  end

  def fetch_phone
    return '' unless @driver.find_elements(:xpath, "//button[text()='Voir les coordonnées']").any?

    phone_button = @driver.find_element(:xpath, "//button[text()='Voir les coordonnées']")

    phone_button.click
    sleep(1)
    phone = @driver.find_elements(:css, 'section[data-theme-class="details-section"] a[data-theme-class="ui-link"]').last

    phone.attribute('href')
  end

  def fetch_address
    return '' unless @driver.find_elements(:xpath, 'div[data-theme-class="footer"]').any?

    container = @driver.find_element(:css, 'div[data-theme-class="footer"]')

    container.text&.gsub("\n", "-")
  end

  def fetch_description
    sections = @driver.find_elements(:css, 'div[data-theme-class="exhibitor-detail"] section')

    description_section = sections.find {|section| section.attribute('data-theme-class').nil? }

    return ''  unless description_section

    description_section.text&.gsub("\n", "-")
  end

  def fetch_activity
    return '' unless @driver.find_elements(:xpath, "//button/span[text()='Activités']").any?

    activity_button = @driver.find_element(:xpath, "//button/span[text()='Activités']")
    activity_button.click

    container = @driver.find_element(:css, 'section[data-theme-class="nomenclatures-card"]')

    activity = container.find_element(:css, 'div.p-4')

    activity.text&.gsub("\n", "-")
  end

  def close_popup
    begin
      return if @driver.find_elements(:css, "div.ub-emb-iframe-wrapper button.ub-emb-close").none?
      
      button = @driver.find_element(:css, "div.ub-emb-iframe-wrapper button.ub-emb-close")  

      button.click
    rescue
      true
    end
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
