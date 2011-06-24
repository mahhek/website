class AudioAttachmentsController < ApplicationController
  def index
  @audio_attachments = current_user.audio_attachments
  respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @audio_attachments }
    end
  end
  
  def new
		@audio_attachment = current_user.audio_attachments.build
	end

  def create
    @audio_attachment = current_user.audio_attachments.build(params[:audio_attachment])
    if params[:audio_attachment][:audio].blank? or params[:audio_attachment][:name].blank?
  		flash[:error] = "Please check below - you may have forgotten to enter a name for your audio file!"
  		render :action => 'new'
  	else	   
      if @audio_attachment.save
        #@audio_attachment.update_attribute(:size, File.size(RAILS_ROOT + "/public" + @audio_attachment.public_filename))
        #@user.audio_attachments_size
        flash[:notice] = 'Audio was successfully attached.'
        redirect_to audio_attachments_path
      else
        render :action => 'new'
      end
	    
    end
  end
end
