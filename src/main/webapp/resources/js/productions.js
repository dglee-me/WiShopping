function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
};

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

$('#select_s').one('click',(function(){
	var selectli = document.createElement('li');
	var price = $('#price').text();
	selectli.innerHTML = "<div class='prdprice_left'>S 사이즈</div>"+
		"\<div class='prdprice_wrap'>" +
		"	\<div class='countopt sml'>" +
		"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" +
		"\<input type='text' class='ipt_count_chk' value='1'>"+
		"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" +
		"\<div class='selling_price'>" +
		"\<strong><em class='num' id='opt_price'>"+price+"</em>원</strong>";
	
	$("#_optionSelectList").append(selectli);
}));

$('#select_m').one('click',(function(){
	var selectli = document.createElement('li');
	var price = $('#price').text();
	selectli.innerHTML = "<div class='prdprice_left'>M 사이즈</div>"+
		"\<div class='prdprice_wrap'>" +
		"	\<div class='countopt sml'>" +
		"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" +
		"\<input type='text' class='ipt_count_chk' value='1'>"+
		"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" +
		"\<div class='selling_price'>" +
		"\<strong><em class='num' id='opt_price'>"+price+"</em>원</strong>";
	
	$("#_optionSelectList").append(selectli);
}));

$('#select_l').one('click',(function(){
	var selectli = document.createElement('li');
	var price = $('#price').text();
	selectli.innerHTML = "<div class='prdprice_left'>L 사이즈</div>"+
		"\<div class='prdprice_wrap'>" +
		"	\<div class='countopt sml'>" +
		"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" +
		"\<input type='text' class='ipt_count_chk' value='1'>"+
		"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" +
		"\<div class='selling_price'>" +
		"\<strong><em class='num' id='opt_price'>"+price+"</em>원</strong>";
	
	$("#_optionSelectList").append(selectli);
}));

$('#select_free').one('click',(function(){
	var selectli = document.createElement('li');
	var price = $('#price').text();
	selectli.innerHTML = "<div class='prdprice_left'>FREE 사이즈</div>"+
		"\<div class='prdprice_wrap'>" +
		"	\<div class='countopt sml'>" +
		"\<a href='javascript:void(0);' class='ico down_count on'>-감소</a>" +
		"\<input type='text' class='ipt_count_chk' value='1'>"+
		"\<a href='javascript:void(0);' class='ico up_count on'>+증가</a></div>" +
		"\<div class='selling_price'>" +
		"\<strong><em class='num' id='opt_price'>"+price+"</em>원</strong>";
	
	$("#_optionSelectList").append(selectli);
}));

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

