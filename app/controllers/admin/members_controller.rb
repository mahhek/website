class Admin::MembersController < ApplicationController
  layout "admin"
  def index
    @members =  params[:search_for].blank? ?  (User.all.paginate :per_page => 200, :page => params[:page]) : (User.search_for(params[:search_for]).paginate :per_page => 200, :page => params[:page])
    @members.sort! { |a,b| a.email <=> b.email }
  end

  def remove
    @member = User.find_by_id(params[:id])
  end

  def destroy
    @member = User.find_by_id(params[:id])
    unless @member.roles("Admin")
      @member.destroy
    else
      flash[:notice] = "Admin accounts cannot be deleted"
    end
    redirect_to admin_members_path
  end

  def new
    @member = User.new
  end

  def create
    @member = User.new(params[:user])
    @user_profile = UserProfile.new(params[:user_profile].merge(:user_id => @member.id))
    if @member.save
      unless params[:user][:instrument_ids].blank?
        params[:user][:instrument_ids].each do |instrument_id|
          unless instrument_id.blank?
            @member.instruments << Instrument.find_by_id(instrument_id)
          end
        end
      end
      unless params[:user][:genre_ids].blank?
        params[:user][:genre_ids].each do |genre_id|
          unless genre_id.blank?
            @member.genres << Genre.find_by_id(genre_id)
          end
        end
      end
      unless params[:user][:business_ids].blank?
        params[:user][:business_ids].each do |business_id|
          unless business_id.blank?
            @member.businesses << Business.find_by_id(business_id)
          end
        end
      end
      @user_profile = UserProfile.new(params[:user_profile].merge(:user_id => @member.id))
      @user_profile.save
      redirect_to admin_members_path
    else
      render :new
    end
  end

  def edit
    @member = User.find_by_id(params[:id])
    @user_profile = @member.user_profile
  end

  def update
    @member = User.find_by_id(params[:id])
    if @member.update_attributes(params[:member])
      unless params[:user][:instrument_ids].blank?
        params[:user][:instrument_ids].each do |instrument_id|
          unless instrument_id.blank?
            @member.instruments << Instrument.find_by_id(instrument_id)
          end
        end
      end
      unless params[:user][:genre_ids].blank?
        params[:user][:genre_ids].each do |genre_id|
          unless genre_id.blank?
            @member.genres << Genre.find_by_id(genre_id)
          end
        end
      end
      unless params[:user][:business_ids].blank?
        params[:user][:business_ids].each do |business_id|
          unless business_id.blank?
            @member.businesses << Business.find_by_id(business_id)
          end
        end
      end
      @user_profile = @member.user_profile
      @user_profile.update_attributes(params[:user_profile])
      flash[:notice] = "Member updated sucessfully"
      redirect_to admin_members_path
    else
      render :edit
    end
  end
end
