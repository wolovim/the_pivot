class PagesController < ApplicationController
  def home
  end

  def code
    redirect_to "https://github.com/ericfransen/dinner_dash.git"
  end
end
