class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => [:show, :edit, :update]

end