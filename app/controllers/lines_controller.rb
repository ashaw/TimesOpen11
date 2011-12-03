class LinesController < ActionController::Base

  def show
    @line = Line.find_by_name(params[:name])
  end

end
