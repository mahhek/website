class HomeController < ApplicationController
  def index
    if current_user && (current_user.role?("Admin") || current_user.role?("Staff"))
        redirect_to "/admin/members"
    end
  end
  

end
