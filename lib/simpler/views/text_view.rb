module Simpler
  class TextView < View
    def self.content_type
      'text/plain'
    end

    private

    def template_extension
      'txt'
    end
  end
end
