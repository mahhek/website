// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
  $(document).ready(function() {
     var audioSection = $('section#song');
     $('a.play_song').click(function() {

     var audio = $('<audio>', {
         controls : 'controls'
     });
     var url = $(this).attr('href');
     $('<source>').attr('src', url).appendTo(audio);
     audioSection.html(audio);
     return false;       });
 }); 
