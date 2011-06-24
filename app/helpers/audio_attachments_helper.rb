module AudioAttachmentsHelper
  def mp3_player xml_path, user
		if not user.audio_attachments.nil? and user.audio_attachments.count > 0
		%{
			<div id="mp3player">
				<div class="right_head">
					<h3>Members audio tracks!</h3>
					To view the mp3 player you will need to have Javascript turned on and have <a href="http://www.adobe.com/go/getflashplayer/" target="_blank">Flash Player 9</a> or better installed.
				</div>
			</div>

			<script type="text/javascript">
				// <![CDATA[

				var so = new SWFObject("/mp3player/ep_player.swf", "ep_player", "269", "226", "9", "#FFFFFF");
				so.addVariable("key", "YCL6SAX27YJSFCSALIPA");
				so.addVariable("skin", "/mp3player/skins/nobius_blue/skin.xml");
				so.addVariable("playlist", "#{xml_path}");
				so.addVariable("autoplay", "false");
				so.addVariable("shuffle", "false");
				so.addVariable("repeat", "false");
				so.addVariable("buffertime", "1");
				so.write("mp3player");

				// ]]>
			</script>
		}
		else
			#'<div class="strong">no sound files</div>'
		end

	end
end
