module DMMCrawler
  module Attributes
    class DojinAttributes < BaseAttributes
      def to_a
        [
          title,
          title_link,
          image_url,
          submedia,
          author,
          affiliateable?,
          tags
        ]
      end

      private

      def title
        @page.search('.productTitle__txt span').remove
        @page.search('.productTitle__txt').text.strip
      end

      def title_link
        @page.uri.to_s
      end

      def image_url
        attrs = @page.search('.productPreview__item img').first.attributes

        if attrs['data-src']
          attrs['data-src'].value
        else
          attrs['src'].value
        end
      end

      def submedia
        @page
          .search('.productAttribute-listItem .c_icon_productGenre')
          .first
          .attributes['class']
          .value
          .gsub('c_icon_productGenre ', '')
          .delete('-')
      end

      def author
        @page.search('div.circleName__item').text.strip
      end

      def brand
        @page.search('.head-detail table tr td').take(8).last
      end

      def tags
        @page.search('.genreTagList .genreTagList__item a').map { |e| e.text.strip }
      end
    end
  end
end
