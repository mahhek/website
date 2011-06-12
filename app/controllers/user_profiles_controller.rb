class UserProfilesController < AuthorizationController
  
  before_filter :logged_in, :only => ['invite_a_friend', 'friends', 'make_friends']
  def index
    @user_profiles = UserProfile.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @user_profiles }
    end
  end

  def show
    @user_profile = UserProfile.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user_profile }
    end
  end


  def new
    @user_profile = UserProfile.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @user_profile }
    end
  end

  def edit    
    @user_profile = UserProfile.find(params[:id], :include => :location)
    @map = GMap.new("map")
    @map.control_init(:map_type => true, :small_zoom => true)
    @map.set_map_type_init(GMapType::G_HYBRID_MAP)
    #    @map.center_zoom_init([52.52, 13.4], 14)
    location = @user_profile.location
    if location
      coordinates = [location.latitude,location.longitude]
      @map.center_zoom_init(coordinates, 14)
      @map.overlay_init(GMarker.new(coordinates,:title => @user_profile.user.first_name, :info_window => "Info! Info!"))

      #      @map.center_zoom_init([52.52, 13.4], 14)

    else
      @map.center_zoom_init([52.52, 13.4], 14)
    end
    
  end

  def create
    @user_profile = UserProfile.new(params[:user_profile])
    respond_to do |format|
      if @user_profile.save
        format.html { redirect_to(@user_profile, :notice => 'User profile was successfully created.') }
        format.xml  { render :xml => @user_profile, :status => :created, :location => @user_profile }
      else
        format.html { render :action => "new" }
        #format.xml  { render :xml => @user_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user_profile = UserProfile.find(params[:id])

    respond_to do |format|
      if @user_profile.update_attributes(params[:user_profile])
        format.html { redirect_to(@user_profile, :notice => 'User profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_profile = UserProfile.find(params[:id])
    @user_profile.destroy

    respond_to do |format|
      format.html { redirect_to(user_profiles_url) }
      format.xml  { head :ok }
    end
  end
  
  def make_friends
    puts current_user.inspect
    puts params[:user_id]
    invite = current_user.invites_in.where(["user_id = ?",  params[:user_id].to_i]).first
    if invite
      puts "invite is #{invite.inspect}"
      invite.is_accepted = 'true'
      invite.save!
      flash[:notice] = t(:friend_request_accepted)
    else
      flash[:notice] = t(:invitation_not_found)
    end
  end
  
  def friends
    @user = current_user
    @invites_in = @user.invites_in.where("is_accepted is null or is_accepted = ?",false)
    @invites_out = @user.invites_out.where("is_accepted is null or is_accepted = ?",false)
  end
  
  def invite_a_friend
    if current_user.can_invite?
      friend = User.find_by_email(params[:email])
      unless friend.blank?
        if current_user == friend
          flash[:warning] = t(:cant_add_self)
        else
          return redirect_to new_user_profile_invite_path(friend.user_profile)
        end
       
      else
        flash[:warning] = t(:no_person_found)
      end
    else
      flash[:notice] = t(:reach_maximum_limit)
    end
    redirect_to "/"
  end
  
  protected
  
  def logged_in
    redirect_to need_to_log_in_first_path unless current_user
  end
end
