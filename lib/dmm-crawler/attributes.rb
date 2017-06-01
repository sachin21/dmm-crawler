module DMMCrawler
  class Attributes
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
      @element.search('.rank-desc').text.nil? ? fetch_description_raw : @element.search('.rank-desc').to_s.tr('"', "'")
    end

    def fetch_description
      url = File.join(BASE_URL, @element.search('.rank-name a').first.attributes['href'].value)
      page = @agent.get(url)
      page.search('.summary .summary__txt').text
    end

    def fetch_description_raw
      url = File.join(BASE_URL, @element.search('.rank-name a').first.attributes['href'].value)
      page = @agent.get(url)
      page.search('.summary .summary__txt').to_s.gsub(/\sclass=".*"/, '').tr('"', "'")
    end

    def tags
      @element.search('.rank-labelListItem').map { |e| e.search('a').text.strip }
    end
  end
end
