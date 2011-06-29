class InvitesController < AuthorizationController
  before_filter :require_user, :only => :accept
  
  def new    
    @user_profile = UserProfile.find(params[:user_profile_id])
    @invitee = Invite.new(:user => @user_profile.user)
  end
  
  def create
    if current_user.can_invite?
      user_to_add = UserProfile.find(params[:user_profile_id]).user
      if user_to_add
        invite = Invite.create(:user => current_user, :user_target => user_to_add, :message => params[:invite][:message])
        unless invite.new_record?
          Notifier.send_network_invitation(current_user, user_to_add, invite).deliver
          flash[:notice] = t(:invitation_created_successfully)
        else          
          flash[:errors] = t(:invitation_could_not_be_created) + invite.errors.full_messages.join("\n")
        end
        return redirect_to user_profile_path(user_to_add.user_profile)
      end
    else      
      flash[:notice] = t(:you_have_reached_you_limit_of_send_invitation)
      return redirect_to user_profile_path(current_user.user_profile)
    end
  end

  def accept    
    @invite = Invite.find_by_code(params[:code])
    if @invite
      @invite.is_accepted = true
      @invite.accepted_at = Time.now
      @invite.save
      Notifier.invitation_accepted_notification(@invite).deliver
      flash[:notice] = "you have accepted and connected successfully!"
      return redirect_to user_profile_path(@invite.user.user_profile)
    else      
      flash[:notice] = "Invitation not found."
      return redirect_to "/"
    end    
  end

  def decline
  
    @invite = Invite.find_by_code(params[:code])
    if @invite
      @invite.destroy
      flash[:notice] = t(:friend_request_declined)
      return redirect_to user_profile_path(current_user.user_profile)
    else
      flash[:notice] = t(:invitation_not_found)
      return redirect_to "/"
    end
  end

  def show
    @invite = Invite.find_by_code(params[:code])
    if @invite.blank?
      flash[:notice] = t(:invitation_already_cancelled)
      redirect_to user_profile_path(current_user.user_profile)
    end
  end
  
  def destroy
    @user = UserProfile.find(params[:id]).user
    @target_user = UserProfile.find(params[:user_profile_id]).user
    
    @invite = Invite.find_by_user_id_and_user_id_target(@user.id, @target_user.id)
    @invite.destroy unless @invite.blank?
    @invite = Invite.find_by_user_id_and_user_id_target(@target_user.id, @user.id)
    @invite.destroy unless @invite.blank?

    flash[:notice] = t(:friend_removed_from_your_network_successfully)
    redirect_to user_profile_path(@target_user.user_profile)
  end
  
end
