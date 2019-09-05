// 정규식
var emailJ = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
var pwJ = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

//	Email 유효성 검사
$("._loginEmailInput").blur(function() {
	var login_email = $("._loginEmailInput").val();
	
	if(emailJ.test(login_email)){
		$(".member_message-area-Email").text("");
		$("._loginEmailInputStatus").css("border","1px solid #ccc");
	}else if(login_email == ""){
		$(".member_message-area-Email").text("이메일을 입력해주세요. :(");
		$(".member_message-area-Email").css("color","red");
		$("._loginEmailInputStatus").css("border","1px solid red");
	}else{
		$(".member_message-area-Email").text("이메일을 형식에 맞게 제대로 입력해주세요. :(");
		$(".member_message-area-Email").css("color","red");
		$("._loginEmailInputStatus").css("border","1px solid red");
	}
});

// Password 유효성 검사
$("._loginPwInput").blur(function(){
	var login_pw = $("._loginPwInput").val();
	if(login_pw != ""){
		$(".member_message-area-Pw").text("");
		$("._loginPwInputStatus").css("border","1px solid #ccc");
	}else if(login_pw == ""){
		$(".member_message-area-Pw").text("비밀번호를 입력해주세요. :(");
		$(".member_message-area-Pw").css("color","red");
		$("._loginPwInputStatus").css("border","1px solid red");
	}
});

//Submit 시 이메일 
function check(){
	var login_email = fr.email.value;
	var login_pw = fr.pw.value;
	
	if(login_email == "" && login_pw == ""){
		$(".member_message-area-Email").text("이메일을 입력해주세요. :(");
		$(".member_message-area-Email").css("color","red");
		$("._loginEmailInputStatus").css("border","1px solid red");
		
		$(".member_message-area-Pw").text("비밀번호를 입력해주세요. :(");
		$(".member_message-area-Pw").css("color","red");
		$("._loginPwInputStatus").css("border","1px solid red");
		
		fr.email.focus()
		return false;
	}else if(login_email == ""){
		$(".member_message-area-Email").text("이메일을 입력해주세요. :(");
		$(".member_message-area-Email").css("color","red");
		$("._loginEmailInputStatus").css("border","1px solid red");

		fr.email.focus()
		return false;
	}else if(login_pw == ""){
		$(".member_message-area-Pw").text("비밀번호를 입력해주세요. :(");
		$(".member_message-area-Pw").css("color","red");
		$("._loginPwInputStatus").css("border","1px solid red");
		
		fr.pw.focus()
		return false;
	}
	
}