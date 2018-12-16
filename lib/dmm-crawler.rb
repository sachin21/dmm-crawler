require 'rdmm'
require 'mechanize'

module DMMCrawler
  BASE_URL = 'http://www.dmm.co.jp'.freeze
end

require 'dmm-crawler/agent'
require 'dmm-crawler/client'
require 'dmm-crawler/attributes/base_attributes'
require 'dmm-crawler/attributes/dojin_attributes.rb'
require 'dmm-crawler/attributes/adult_game_attributes.rb'
require 'dmm-crawler/ranking/base_ranking'
require 'dmm-crawler/ranking/dojin_ranking.rb'
require 'dmm-crawler/ranking/adult_game_ranking.rb'
require 'dmm-crawler/version'
