module DMMCrawler
  class Attributes
    def initialize(element, submedia = nil)
      @agent = Agent.instance.agent
      @element = element

      @submedia = submedia
    end

    def to_a
      [
        title,
        title_link,
        image_url,
        description,
        description_raw,
        submedia,
        informations,
        tags
      ]
    end

    private

    def title
      if art_page?
        @element.search('.productTitle__txt span').remove
        @element.search('.productTitle__txt').text.strip
      else
        @element.search('.rank-name').first.text.strip
      end
    end

    def image_url
      if art_page?
        @element.search('.productPreview__item img').last.attributes['data-src'].value
      else
        @element.search('img').last.attributes['src'].value
      end
    end

    def title_link
      if art_page?
        @element.uri.to_s
      else
        File.join(BASE_URL, @element.search('.rank-name').first.search('a').first.attributes.first[1].value)
      end
    end

    def description
      if art_page?
        @element.search('.summary .summary__txt').text
      else
        @element.search('.rank-desc').text
      end.strip
    end

    def description_raw
      if art_page?
        @element.search('.summary .summary__txt').to_s.gsub(/\sclass=".*"/, '').tr('"', "'")
      else
        @element.search('.rank-desc').to_s.tr('"', "'")
      end
    end

    def submedia
      return @submedia if @submedia

      @element
        .search('.productAttribute-listItem .c_icon_productGenre')
        .first
        .attributes['class']
        .value
        .gsub('c_icon_productGenre ', '')
        .delete('-')
    end

    def informations
      keys = extract_text(@element.search('.m-productInformation .productInformation__item .informationList__ttl'))
      values = extract_text(@element.search('.m-productInformation .productInformation__item .informationList__txt'))

      keys.zip(values).map { |key, value| { key: key, value: value } }
    end

    def extract_text(elements)
      elements
        .select { |element| element.text.strip != 'ジャンル' }
        .map { |element| element.children.text.strip }
    end

    def tags
      if art_page?
        @element.search('.genreTagList .genreTagList__item a').map { |e| e.text.strip }
      else
        @element.search('.rank-labelListItem').map { |e| e.search('a').text.strip }
      end
    end

    def art_page?
      @element.search('.rank-name').empty?
    end
  end
end
