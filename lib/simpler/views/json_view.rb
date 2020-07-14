require 'json'

module Simpler
  class JsonView < View
    def self.content_type
      'application/json'
    end

    private

    def template_extension
      'json'
    end

    def data
      @data ||= @env['simpler.data'].to_json
    end
  end
end
