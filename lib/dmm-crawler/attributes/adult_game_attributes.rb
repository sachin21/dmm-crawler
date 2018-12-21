module DMMCrawler
  module Attributes
    class AdultGameAttributes < BaseAttributes
      def to_a
        [
          title,
          title_link,
          main_image_url,
          sample_image_urls,
          submedia,
          brand,
          affiliateable?,
          tags
        ]
      end

      private

      def title
        @page.search('.page-detail h1').first.children.last.text.strip.gsub(/【.*】/, '')
      end

      def title_link
        @page.uri.to_s
      end

      def main_image_url
        @page.search('.area-package-image').search('.package-image-box a').first.attributes['href'].value
      end

      def sample_image_urls
        @page.search('#item-rotationbnr li span img').take(3).map { |img| img&.attributes&.send(:[], 'src')&.value }.compact
      end

      def submedia
        'adult_game'
      end

      def brand
        @page.search('.head-detail table tr td').take(8).last.text.strip
      end

      def tags
        @page.search('.area-bskt  tbody  tr')[4].search('td a').map { |elm| elm.text.strip }
      end

      def content_id
        @page.uri.to_s.match(/views_\d*/)
      end
    end
  end
end
