require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      return data if data

      template_nm = template_name
      @env['simpler.template_name'] = template_nm

      template = File.read(template_path(template_nm))

      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def data
      @data ||= @env['simpler.data']
    end

    def template
      @env['simpler.template']
    end

    def template_name
      path = template || [controller.name, action].join('/')
      "#{path}.#{template_extension}.erb"
    end

    def template_path(name)
      Simpler.root.join(VIEW_BASE_PATH, name)
    end

    def template_extension; end

  end
end

require_relative 'views/html_view'
require_relative 'views/json_view'
require_relative 'views/text_view'
