var emailJ = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
var pwJ = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
var nameJ = /^[가-힣]{2,6}$/;
var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

//	Email 유효성 검사(1 = 중복 / 0 != 중복)
$("#join_email").blur(function() {
	var join_email = $('#join_email').val();
	$.ajax({
		url : '/myapp/auth/emailCheck?join_email='+join_email,
		type : 'get',
		success : function(data){
			console.log("1 = 중복 O / 0 = 중복 X : "+ data);
			
			if(data == 1){
				// 1 : 이메일이 중복되는 때의 문구
				$(".member_message-area-Email").text("등록된 이메일입니다. :(");
				$(".member_message-area-Email").css("color","red");
				$("._joinEmailInputStatus").css("border","1px solid red");
			}else{
				if(emailJ.test(join_email)){
					$(".member_message-area-Email").text("");
					$("._joinEmailInputStatus").css("border","1px solid #ccc");
				}else if(join_email == ""){
					$(".member_message-area-Email").text("이메일을 입력해주세요. :)");
					$(".member_message-area-Email").css("color","red");
					$("._joinEmailInputStatus").css("border","1px solid red");
				}else{
					$(".member_message-area-Email").text("이메일을 제대로 입력해주세요. :(");
					$(".member_message-area-Email").css("color","red");
					$("._joinEmailInputStatus-Email").css("border","1px solid red");
				}
			}
		}, error : function(){
			console.log("실패");
		}
	});
});

//비밀번호 유효성 검사
$("#join_pw").blur(function() {
    if(pwJ.test($("#join_pw").val())){
    	$(".member_message-area-Pw").text("");
    }else{
        $(".member_message-area-Pw").text("비밀번호는 6~15자 이내로 영문 숫자 특수문자를 포함해야 합니다.");
        $(".member_message-area-Pw").css("color","red");
    }
});

//비밀번호 재확인 유효성 검사
$("#join_pw_again").blur(function() {
	if($("#join_pw").val() != $(this).val()){
		$(".member_message-area-Pw-again").text("비밀번호가 일치하지 않습니다. :(");
		$(".member_message-area-Pw-again").css("color","red");
	}else{
		$(".member_message-area-Pw-again").text("");
	}
});

//이름 유효성 검사
$("#join_name").blur(function() {
	if(nameJ.test($("#join_name").val())){
		console.log($(this).val());
		$(".member_message-area-name").text("");
	}else{
		console.log("잘못된 이름 입력");
		$(".member_message-area-name").text("이름을 확인해주세요.");
		$(".member_message-area-name").css("color","red");
	}
});


//휴대전화 유효성 검사
$("#join_tel").blur(function() {
	if(phoneJ.test($(this).val())){
		console.log(phoneJ.test($(this).val()));
		$(".member_message-area-tel").text("");
	}else{
		$(".member_message-area-tel").text("휴대폰 번호를 확인해주세요.");
		$(".member_message-area-tel").css("color","red");
	}
});

// 회원가입 유효성 검사
var inval_arr = new Array(4).fill(false);

$("._joinTrigger").click(function(){
	//이메일 정규식
	if(emailJ.test($("#join_email").val())){
		inval_arr[0] = true;
	}else{
		inval_arr[0] = false;
	}
	
	//비밀번호가 같은 경우 && 비밀번호 정규식
	if($("#join_pw").val() == ($("#join_pw_again").val()) && pwJ.test($("#join_pw").val())){
		inval_arr[1] = true;
	}else{
		inval_arr[1] = false;
	}
	
	//이름 정규식
	if(nameJ.test($("#join_name").val())){
		inval_arr[2] = true;
	}else{
		inval_arr[2] = false;
	}
	
	//휴대전화 정규식
	if(phoneJ.test($("#join_tel").val())){
		inval_arr[3] = true;
	}else{
		inval_arr[3] = false;
	}
	
	var validAll = true;
	for(var i = 0; i < inval_arr.length; i++){
		if(inval_arr[i] == false){
			validAll = false;
			console.log("inval_arr["+i+"] = "+validAll);
		}
	}
	
	//유효성 모두 통과
	if(validAll == true){
		alert("가입한 이메일로 인증 이메일을 보냈으니 확인해주세요! :)");
		document.join_frm.submit();
	}else{
		alert("입력한 정보들을 다시 확인 해주세요! :(");
	}
});