class Notifier < ActionMailer::Base

  def send_network_invitation(from, to,invite)
    @receiver = to
    @sender = from    
    @url = "http://#{SITE_URL}/invitation/#{invite.code}"
    @message = invite.message
    mail( :from => from.email, :to => to.email,
      :subject => "Musociety: #{@sender.fullname} is interested to connect.",
      :content_type => "text/html"
    )
  end

  def invitation_accepted_notification(invite)
    @receiver = invite.user
    @sender = invite.user_target
    mail( :from => "notification@musociety.com", :to => @receiver.email,
      :subject => "Musociety: #{@sender.fullname} has accepted your invitation",
      :content_type => "text/html")
  end

  def registration_invitation(current_user, invitee_user)
    @receiver = invitee_user
    @sender = current_user
    @url = "http://#{SITE_URL}/users/signup/#{@receiver.invite_token}"
    @message = "Some generic message"
    mail( :from => current_user.email, :to => invitee_user.email,
      :subject => "Musociety: #{@sender.fullname} is interested to connect.",
      :content_type => "text/html"
    )
  end
end
