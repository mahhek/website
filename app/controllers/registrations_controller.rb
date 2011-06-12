class RegistrationsController < Devise::RegistrationsController  
  prepend_view_path "app/views/devise"
  #
  def new
    @roles = Role.user_roles
    super
  end
  
  #
  #
  def create    
    build_resource
    @roles = Role.user_roles
    if params[:role]
      @role  = Role.find_by_id(params[:role])
      resource.roles << @role
      if resource.save
        @user_profile = resource.create_user_profile.inspect
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up
          sign_in_and_redirect(resource_name, resource)
        else
          set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s
          expire_session_data_after_sign_in!
          redirect_to after_inactive_sign_up_path_for(resource)
        end
      else        
        clean_up_passwords(resource)
        render_with_scope :new
      end
    else
      set_flash_message :alert, :need_role_selection
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end
end
