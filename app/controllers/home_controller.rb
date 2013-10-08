class HomeController < ApplicationController
	layout "base"
	  def index
	  	@users = User.all
	  end
end
