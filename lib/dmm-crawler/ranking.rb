module DMMCrawler
  class Ranking
    BASE_URL = 'http://www.dmm.co.jp'.freeze

    def initialize(arguments)
      @term = discriminate_term(arguments[:term])
      @submedia = discriminate_submedia(arguments[:submedia])
      @url = "#{BASE_URL}/dc/doujin/-/ranking-all/=/sort=popular/submedia=#{@submedia}/term=#{@term}"
      @agent = Agent.new.agent
    end

    def arts
      arts = page.search('.rank-rankListItem.fn-setPurchaseChange').map do |element|
        [
          element.search('.rank-name').first.text.strip,
          element.search('img').last.attributes['src'].value,
          "#{BASE_URL}#{element.search('.rank-name').first.search('a').first.attributes.first[1].value}",
          element.search('.rank-desc').text,
          element.search('.rank-labelListItem').map { |e| e.search('a').text.strip }
        ]
      end

      arts.map.with_index(1) do |(title, image_url, title_link, description, tags), rank|
        {
          title: "#{rank}位: #{title}",
          title_link: title_link,
          image_url: image_url,
          description: description,
          tags: tags
        }
      end
    end

    private

    def page
      @agent.get(@url)
    end

    def discriminate_term(term)
      return term if %w(24 weekly monthly total).include?(term)
      raise TypeError
    end

    def discriminate_submedia(submedia)
      return submedia if %w(all comic cg game voice).include?(submedia)
      raise TypeError
    end
  end
end
