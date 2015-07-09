class HomeController < ApplicationController
  def index
  	if Admin.all.count==0
  		redirect_to "/admins/sign_up"
  	end
  end
end
