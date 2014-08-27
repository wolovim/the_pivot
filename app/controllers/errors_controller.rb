class ErrorsController < ApplicationController
  def routing_error
      render "404", :status => 404
  end
end
