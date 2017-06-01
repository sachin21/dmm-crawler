module DMMCrawler
  class Ranking
    def initialize(arguments)
      @term = discriminate_term(arguments[:term])
      @submedia = discriminate_submedia(arguments[:submedia])
      @url = File.join(BASE_URL, "/dc/doujin/-/ranking-all/=/sort=popular/submedia=#{@submedia}/term=#{@term}")
      @agent = Agent.instance.agent
    end

    def arts
      arts = page.search('.rank-rankListItem.fn-setPurchaseChange').map do |element|
        Attributes.new(element, @submedia).to_a
      end

      arts.map.with_index(1) do |(title, title_link, image_url, description, description_raw, submedia, tags), rank|
        {
          title: "#{rank}位: #{title}",
          title_link: title_link,
          image_url: image_url,
          description: description,
          description_raw: description_raw,
          submedia: submedia,
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
