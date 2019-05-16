# frozen_string_literal: true

module DMMCrawler
  module Ranking
    class AdultGameRanking < BaseRanking
      include Attributes

      FETCHING_LIMITATION = 20
      DLSOFT_URL = 'https://dlsoft.dmm.co.jp/'.freeze

      def initialize(agent: Agent.instance.agent, term: nil)
        @agent = discriminate_agent(agent)
        @term = term
        @url = URI.join(DLSOFT_URL, File.join('ranking', parameterized_term))
      end

      def arts
        games = page.search('.rankingList-content .rankingList-item.fn-rankListItem').take(FETCHING_LIMITATION)
        arts = games.map do |game|
          sleep_each do
            url = game.search('.rankingList-link').first.attributes['href'].value
            AdultGameAttributes.new(url, agent: @agent).to_a
          end
        end

        arts.map.with_index(1) do |(title, title_link, main_image_url, sample_image_urls, submedia, author, affiliateable, tags), rank|
          {
            title: title,
            title_link: title_link,
            main_image_url: main_image_url,
            sample_image_urls: sample_image_urls,
            submedia: submedia,
            author: author,
            rank: rank,
            affiliateable: affiliateable,
            tags: tags
          }
        end
      end

      private

      def parameterized_term
        case @term
        when 'weekly'
          'term=weekly'
        when 'monthly'
          ''
        when 'yearly'
          'term=all/year=2018'
        end
      end
    end
  end
end
