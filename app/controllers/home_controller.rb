class HomeController < ApplicationController
  def index    
    @map = GMap.new("map")
    @map.control_init(:map_type => true, :small_zoom => true)
    @map.center_zoom_init([40.600607532515816, -82.79296875], 5)

    if current_user && (current_user.role?("Admin") || current_user.role?("Staff"))
      redirect_to "/admin/members"
    end    
  end
  

end
