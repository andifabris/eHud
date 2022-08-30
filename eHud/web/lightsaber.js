$(document).ready(function(){
  window.addEventListener('message', function(event){
    var data = event.data;
    if (data.display == true) {
      $('#hud').fadeIn();
      $('body').show();
    }   
    else {
      $('#hud').fadeOut();
    }



    $("#bodyarmor").css("width", (data.armour) + "%");
    $("#life").css("width", (data.health) + "%");
    if (data.stress >= 10) {
      $(".stress span").css('background-image', 'linear-gradient(to top, #6effc3, #49ff70)');
    }
    if (data.stress >= 50) {
      $(".stress span").css('background-image', 'linear-gradient(to top, rgb(238, 168, 62), rgb(255, 240, 34))');
    }
    if (data.stress >= 80) {
      $(".stress span").css('background-image', 'linear-gradient(to top, rgb(196, 43, 43), rgb(255, 34, 34))');
    }
    $("#stress").css("height", data.stress +"%");
    $("#hungry").css("height", data.hunger +"%");
    $("#thirst").css("height", data.thirst +"%");



    if (data.vehicle == true) {
      $('#vehicle').fadeIn(950).css('right', '20px');
    } 
    else {
      $('#vehicle').css('right', '-330px');
      $('#vehicle').fadeOut(950);
    }
    if (data.seatbelt == 1) {
      $("#seatbelt").html("<img src='images/seatbeltOff.svg'>"); 
    }  
    if (data.seatbelt == 2) {
      $("#seatbelt").html("<img src='images/seatbeltOn.svg'>"); 
    } 
    if (data.seatbelt == 3) {
      $("#seatbelt").html("<img src='images/seatbeltNeeded.svg'>"); 
    } 

    if (data.engine == true) {
      $("#engine").html("<img src='images/engineOn.svg'>"); 
    }   
    else {
      $("#engine").html("<img src='images/engineOff.svg'>"); 
    }
    if (data.headlight == 0) {
      $("#headlight").html("<img src='images/headlightOff.svg'>"); 
    }   
    if (data.headlight == 1) {
      $("#headlight").html("<img src='images/headlightLow.svg'>"); 
    }   
    if (data.headlight == 2) {
      $("#headlight").html("<img src='images/headlightHight.svg'>"); 
    }
    $("#kmh").html(parseInt(data.speed));
    document.querySelector('#progressSpeedometer svg circle.speed').style.strokeDashoffset = event.data.speedNail;
		document.querySelector('#progressTachometer svg circle.rpm').style.strokeDashoffset = event.data.rpmNail;
    $("#gear").html(data.gear);
    $(".fuel").css("height", data.fuel + "%");



    $("#voice").html("<img src='images/voice.svg'><p>" + data.voice + '</p>');
    $("#time").html("<img src='images/time.png'><p>" + data.hours + ':' + data.minutes + '</p>');
    $("#address").html("<img src='images/address.png'><p>" + data.address + '.</p>');
    if (data.talking == true) {
      $('#voice').css('color', '#ffb031');
      $("#voice").html("<img src='images/voiceOn.png'><p>" + data.voice + '</p>');
    }   
    else {
      $('#voice').css('color', 'white');
      $('#radio').css('color', 'white');  
      $("#voice").html("<img src='images/voiceOff.png'><p>" + data.voice + '</p>');
      $("#radio").html("<img src='images/radioOff.png'><p>" + data.radio + '</p>');
    }
    if (data.radio !== undefined) {
      $("#radio").css("display", "block");
    }
    else {
      $("#radio").css("display", "none"); 
    }
  });
});