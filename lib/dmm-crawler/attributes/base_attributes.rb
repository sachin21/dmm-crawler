# frozen_string_literal: true

module DMMCrawler
  module Attributes
    class BaseAttributes
      HTTP_STATUS_CODE_OF_SUCCESS = 200

      def initialize(url, agent: Agent.instance.agent)
        @page = agent.get(url)
        @r_client = Rdmm::Client.new(affiliate_id: ENV['DMM_AFFILIATE_ID'], api_id: ENV['DMM_API_ID'])
      end

      def to_a
        raise NotImplementedError
      end

      private

      def affiliateable?
        @r_client.list_items(site: 'DMM.R18', keyword: title).body['result']['status'] == HTTP_STATUS_CODE_OF_SUCCESS
      end

      def art_page?
        @page.uri.to_s =~ /doujin/
      end

      def adult_game?
        @page.uri.to_s =~ /dlsoft/
      end

      def title
        raise NotImplementedError
      end

      def title_link
        raise NotImplementedError
      end

      def image_url
        raise NotImplementedError
      end

      def submedia
        raise NotImplementedError
      end

      def author
        raise NotImplementedError
      end

      def brand
        raise NotImplementedError
      end

      def tags
        raise NotImplementedError
      end
    end
  end
end
