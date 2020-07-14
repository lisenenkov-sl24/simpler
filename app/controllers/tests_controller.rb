class TestsController < Simpler::Controller

  def index
    @time = Time.now
    status 201
    headers['Content-Type'] = 'text/plain'
  end

  def show
    render html: "Plain text #{params}"
  end
  
  def plain
    render plain: 'Plain text'
  end

  def json
    render json: { data: :ddd }
  end

  def create

  end

end
