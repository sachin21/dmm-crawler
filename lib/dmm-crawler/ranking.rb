module DMMCrawler
  class Ranking
    def initialize(arguments)
      @agent = discriminate_agent(arguments[:agent])
      @term = discriminate_term(arguments[:term])
      @submedia = arguments[:submedia]
      @url = File.join(BASE_URL, "/dc/doujin/-/ranking-all/=/sort=popular/submedia=#{@submedia}/term=#{@term}")
    end

    def arts
      arts = page.search('.rank-rankListItem.fn-setPurchaseChange').take(10).map do |element|
        sleep_each do
          url = File.join(BASE_URL, element.search('.rank-name a').first.attributes['href'].value)
          Attributes.new(url).to_a
        end
      end

      arts.map.with_index(1) do |(title, title_link, image_url, submedia, author, informations, tags), rank|
        {
          title: "#{rank}位: #{title}",
          title_link: title_link,
          image_url: image_url,
          submedia: submedia,
          author: author,
          informations: informations,
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

    def discriminate_agent(agent)
      return agent if agent.is_a?(Mechanize)
      raise TypeError
    end

    def sleep_each
      sleep rand(0.7..1.3)
      yield
    end
  end
end
