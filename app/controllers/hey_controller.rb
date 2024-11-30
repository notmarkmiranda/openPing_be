class HeyController < ApplicationController
  def random
    render json: { message: "I'm a teapot" }, status: 418
  end
end
