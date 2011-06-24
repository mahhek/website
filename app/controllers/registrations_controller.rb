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
        unless params[:user][:instrument_ids].blank?
          params[:user][:instrument_ids].each do |instrument_id|
            unless instrument_id.blank?
              resource.instruments << Instrument.find_by_id(instrument_id)
            end
          end
        end
        unless params[:user][:genre_ids].blank?
          params[:user][:genre_ids].each do |genre_id|
            unless genre_id.blank?
              resource.genres << Genre.find_by_id(genre_id)
            end
          end
        end
        unless params[:user][:business_ids].blank?
          params[:user][:business_ids].each do |business_id|
            unless business_id.blank?
              resource.businesses << Business.find_by_id(business_id)
            end
          end
        end
        @user_profile = UserProfile.new(params[:user_profile].merge(:user_id => resource.id))
        @user_profile.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up
          sign_in_and_redirect(resource_name, resource)
        else
          set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s
          expire_session_data_after_sign_in!
          redirect_to after_inactive_sign_up_path_for(resource)
        end
      else
        @user_profile = UserProfile.new(params[:user_profile])
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
