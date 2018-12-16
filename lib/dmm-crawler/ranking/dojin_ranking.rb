module DMMCrawler
  module Ranking
    class DojinRanking < BaseRanking
      include Attributes

      FETCHING_LIMITATION = 10

      def initialize(agent:, submedia: nil, term: nil)
        @agent = discriminate_agent(agent)
        @submedia = submedia
        @term = submedia
        @url = File.join(BASE_URL, "/dc/doujin/-/ranking-all/=/sort=popular/submedia=#{@submedia}/term=#{@term}")
      end

      def arts
        arts = page.search('.rank-rankListItem.fn-setPurchaseChange').take(FETCHING_LIMITATION).map do |element|
          sleep_each do
            url = File.join(BASE_URL, element.search('.rank-name a').first.attributes['href'].value)
            DojinAttributes.new(url, agent: @agent).to_a
          end
        end

        arts.map.with_index(1) do |(title, title_link, image_url, submedia, author, price, affiliateable, tags), rank|
          {
            title: title,
            title_link: title_link,
            image_url: image_url,
            submedia: submedia,
            author: author,
            rank: rank,
            price: price,
            affiliateable: affiliateable,
            tags: tags
          }
        end
      end
    end
  end
end
