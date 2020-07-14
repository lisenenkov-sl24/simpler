module Simpler
  class Router
    class Route
      PATH_SEPARATOR = '/'.freeze

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = split_path(path)
        @controller = controller
        @action = action
      end

      def match(method, path)
        return nil if @method != method

        match_path(path)
      end

      private

      def match_path(path)
        path_params = {}
        @path.zip(split_path(path)).each do |route_path, request_path|
          if route_path.start_with? ':'
            path_params[route_path[1..-1]] = request_path
          elsif route_path != request_path
            return nil
          end
        end
        path_params
      end

      def split_path(path)
        path.split(PATH_SEPARATOR).reject(&:empty?)
      end
    end
  end
end
