var s_count = 0;
var m_count = 0;
var l_count = 0;
var free_count = 0;

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
};

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

$(document).ready(function(){
	$(document).on("click",".close",function(){
		$(this).closest('li').remove();
		
		if($(this).closest('li').children('.prdprice_left').text() == 'S 사이즈'){
			s_count = 0;
		}else if($(this).closest('li').children('.prdprice_left').text() == 'M 사이즈'){
			m_count = 0;
		}else if($(this).closest('li').children('.prdprice_left').text() == 'L 사이즈'){
			l_count = 0;
		}else{
			free_count = 0;
		}
	});
});

$('#select_s').click(function(){
	if(s_count<1){
		var selectli = document.createElement('li');
		var price = $('#price').text();
		selectli.innerHTML = "<div class='prdprice_left'>S 사이즈</div>"+
			"\<div class='prdprice_wrap'>" +
			"	\<div class='countopt sml'>" +
			"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" +
			"\<input type='text' class='ipt_count_chk' value='1'>"+
			"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" +
			"\<div class='selling_price'>" +
			"\<strong><em class='num' id='opt_price'>"+price+"</em>원</strong>" +
			"\<a href='javascript:void(0);' class='btn close'>취소</a>";
		
		$("#_optionSelectList").append(selectli);
		s_count=1;
	}else{
		alert('같은 옵션은 1번만 선택할 수 있습니다.');
	}
	
});

$('#select_m').click(function(){
	if(m_count<1){
		var selectli = document.createElement('li');
		var price = $('#price').text();
		selectli.innerHTML = "<div class='prdprice_left'>M 사이즈</div>"+
			"\<div class='prdprice_wrap'>" +
			"	\<div class='countopt sml'>" +
			"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" +
			"\<input type='text' class='ipt_count_chk' value='1'>"+
			"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" +
			"\<div class='selling_price'>" +
			"\<strong><em class='num' id='opt_price'>"+price+"</em>원</strong>" +
			"\<a href='javascript:void(0);' class='btn close'>취소</a>";
		
		$("#_optionSelectList").append(selectli);
		m_count=1;
	}else{
		alert('같은 옵션은 1번만 선택할 수 있습니다.');
	}
	
});

$('#select_l').click(function(){
	if(l_count<1){
		var selectli = document.createElement('li');
		var price = $('#price').text();
		selectli.innerHTML = "<div class='prdprice_left'>L 사이즈</div>"+
			"\<div class='prdprice_wrap'>" +
			"	\<div class='countopt sml'>" +
			"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" +
			"\<input type='text' class='ipt_count_chk' value='1'>"+
			"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" +
			"\<div class='selling_price'>" +
			"\<strong><em class='num' id='opt_price'>"+price+"</em>원</strong>" +
			"\<a href='javascript:void(0);' class='btn close'>취소</a>";
		
		$("#_optionSelectList").append(selectli);
		l_count=1;
	}else{
		alert('같은 옵션은 1번만 선택할 수 있습니다.');
	}
});

$('#select_free').click(function(){
	if(free_count<1){
		var selectli = document.createElement('li');
		var price = $('#price').text();
		selectli.innerHTML = "<div class='prdprice_left'>FREE 사이즈</div>"+
			"\<div class='prdprice_wrap'>" +
			"	\<div class='countopt sml'>" +
			"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" +
			"\<input type='text' class='ipt_count_chk' value='1'>"+
			"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" +
			"\<div class='selling_price'>" +
			"\<strong><em class='num' id='opt_price'>"+price+"</em>원</strong>" +
			"\<a href='javascript:void(0);' class='btn close'>취소</a>";
		
		$("#_optionSelectList").append(selectli);
		free_count=1;
	}else{
		alert('같은 옵션은 1번만 선택할 수 있습니다.');
	}
});

/*Count num ++ event*/
$(document).ready(function(){
	$(document).on("click",".up_count",function(){
		var count = $('.ipt_count_chk').val();
		var num = parseInt(count,10);
		
		var optPrice = parseInt(uncomma($('#price').text()),10);
		
		num++;
		
		$('.ipt_count_chk').val(num);
		
		$('#opt_price').text(comma(optPrice*num));
	});
});

/*Count num -- event*/
$(document).ready(function(){
	$(document).on("click",".down_count",function(){
		var count = $('.ipt_count_chk').val();
		var num = parseInt(count,10);

		var optPrice = parseInt(uncomma($('#price').text()),10);
		
		num--;
		
		if(num<=0){
			alert("수량을 더 내릴 수 없습니다.");
			num = 1;
		}

		$('#opt_price').text(comma(optPrice*num));
		$('.ipt_count_chk').val(num);
	});
});

