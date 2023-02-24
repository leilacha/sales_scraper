require 'selenium-webdriver'
require 'interactor'
require_relative 'search_item'
require_relative 'select_item'
require_relative 'scrap_info'

class ScrapingOrganizer
  include Interactor::Organizer

  organize SearchItem, SelectItem, ScrapInfo
end
