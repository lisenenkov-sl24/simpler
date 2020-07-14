require_relative '../view'

module Simpler
  class HtmlView < View
    def self.content_type
      'text/html'
    end

    private

    def template_extension
      'html'
    end
  end
end
