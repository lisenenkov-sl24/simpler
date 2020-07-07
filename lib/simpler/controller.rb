require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env, path_params)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @path_params = path_params
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      send(action)
      set_default_headers
      write_response

      @response.finish
    end

    def headers
      @response.headers
    end

    def status(v)
      @response.status = v
    end

    def self.not_found(_)
      [404, { 'Content-Type' => 'text/plain' }, ['Not found']]
    end

    def params
      @request.params.merge @path_params
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] ||= view_type.content_type
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      view_type.new(@request.env).render(binding)
    end

    def render(template)
      if !template.respond_to? :to_hash
        @request.env['simpler.template'] = template
      elsif template[:html]
        @request.env['simpler.viewtype'] = HtmlView
        @request.env['simpler.data'] = template[:html]
      elsif template[:plain]
        @request.env['simpler.viewtype'] = TextView
        @request.env['simpler.data'] = template[:plain]
      elsif template[:json]
        @request.env['simpler.viewtype'] = JsonView
        @request.env['simpler.data'] = template[:json]
      end
    end

    def view_type
      @request.env['simpler.viewtype'] || HtmlView
    end

  end
end
