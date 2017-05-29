module DMMCrawler
  class Ranking
    BASE_URL = 'http://www.dmm.co.jp'.freeze

    def initialize(arguments)
      @term = discriminate_term(arguments[:term])
      @submedia = discriminate_submedia(arguments[:submedia])
      @url = File.join(BASE_URL, "/dc/doujin/-/ranking-all/=/sort=popular/submedia=#{@submedia}/term=#{@term}")
      @agent = Agent.instance.agent
    end

    def arts
      arts = page.search('.rank-rankListItem.fn-setPurchaseChange').map do |element|
        Attribute.new(element).to_a
      end

      arts.map.with_index(1) do |(title, title_link, image_url, description, description_raw, tags), rank|
        {
          title: "#{rank}位: #{title}",
          title_link: title_link,
          image_url: image_url,
          description: description,
          description_raw: description_raw,
          tags: tags
        }
      end
    end

    class Attribute
      def initialize(element)
        @element = element
        @agent = Agent.instance.agent
      end

      def to_a
        [
          title,
          title_link,
          image_url,
          description,
          description_raw,
          tags
        ]
      end

      private

      def title
        @element.search('.rank-name').first.text.strip
      end

      def image_url
        @element.search('img').last.attributes['src'].value
      end

      def title_link
        File.join(BASE_URL, @element.search('.rank-name').first.search('a').first.attributes.first[1].value)
      end

      def description
        @element.search('.rank-desc').text.nil? ? fetch_description : @element.search('.rank-desc').text
      end

      def description_raw
        @element.search('.rank-desc').text.nil? ? fetch_description_raw : @element.search('.rank-desc').to_s
      end

      def fetch_description
        url = File.join(BASE_URL, @element.search('.rank-name a').first.attributes['href'].value)
        page = @agent.get(url)
        page.search('.summary .summary__txt').text
      end

      def fetch_description_raw
        url = File.join(BASE_URL, @element.search('.rank-name a').first.attributes['href'].value)
        page = @agent.get(url)
        page.search('.summary .summary__txt').to_s.gsub(/\sclass=".*"/, '')
      end

      def tags
        @element.search('.rank-labelListItem').map { |e| e.search('a').text.strip }
      end
    end

    private_constant :Attribute

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
