/* Common script*/

function bookmarksite(){
	//IE
	var agent = navigator.userAgent.toLowerCase();
	if((navigator.appName == "Netscape" && agent.indexOf("trident") != -1) || (agent.indexOf("msie") != -1)){
		window.external.AddFavorite("http://localhost:8081/WiShopping","위쇼핑");
	}
	//Google Chrome
	else if(window.chrome){
		alert("Ctrl+D키로 즐겨찾기에 추가하실 수 있습니다.");
	}
	else if(window.external){
		window.external.AddFavorite(url,title);
	}
}

function header_search(query){
	document.header_search_bar.submit();
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
};

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

//만약 td 내의 text가 같다면, rowspan 설정
function tableRowSpanning(table, spanning_row_index){
	var rowspan_td = false;
	var rowspan_column_name = false;
	var rowspan_count = 0;
	var rows = $("tr",table);
	
	$.each(rows, function(){
		var thisObject = $("td", this)[spanning_row_index];
		var text = $(thisObject).text();

		if(rowspan_td == false){
			rowspan_td = thisObject;
			rowspan_column_name = text;
			rowspan_count = 1;
		}else if(rowspan_column_name != text){
			$(rowspan_td).attr("rowspan", rowspan_count);
			
			rowspan_td = thisObject;
			rowspan_column_name = text;
			rowspan_count = 1;
		}else{
			$(thisObject).remove();
			rowspan_count++;
		}
	});
	
	$(rowspan_td).attr("rowspan", rowspan_count);
}

function direct_productionOptionCheck(input){
	var ono = input.closest("article").children("h1").attr("data-number");
	var now = parseInt(input.val(),10);
	var price = parseInt(uncomma($('#price').text()),10);
	
	var options = $(".selling-option-item_price_number");
	
	if(now < 1){
		alert("상품의 수량을 1개 이상으로 설정하여주세요.");
		input.val(1);
		input.closest("article").children("div").children("p").children("span").text(comma(price)+" ");

		var total_price = 0;
		$.each(options, function(){
			total_price += parseInt(uncomma($(this).text()),10);
		});

		$(".selling-option-form-content_price_number").text(comma(total_price));
	}else{
		$.ajax({
			url : "/WiShopping/productions/view/checkOption",
			type : "post",
			data : {ono : ono},
			success : function(result){
				if(now > result){
					alert("선택한 수량이 재고보다 많습니다!");
					
					//Setting price and input value
					input.val(previous);				
					input.closest("article").children("div").children("p").children("span").text(comma(price * previous)+" ");//The reason for adding " " is because it splits above to compare option duplication.
				}else{
					input.closest("article").children("div").children("p").children("span").text(comma(price * now)+" ");
					
					var total_price = 0;
					$.each(options, function(){
						total_price += parseInt(uncomma($(this).text()),10);
					});
					
					$(".selling-option-form-content_price_number").text(comma(total_price));
				}
			}
		});
	}
}

function productionOptionCheck(input){
	var ono = input.closest("article").children("h1").attr("data-number");
	var inventory;
	
	$.ajax({
		url : "/WiShopping/productions/view/checkOption",
		type : "post",
		async : false,
		data : {ono : ono},
		success : function(result){
			inventory = result;
		}
	});
	return inventory;
}

//Change Time Format (minutes ago)
function dateTimeToFormat(date){
	var min = 60 * 1000;
	var c = new Date();
	var d = new Date(date);
	var minsAgo = Math.floor((c - d) / (min));
	
	var result = {
		'raw': d.getFullYear() + '-' + (d.getMonth() + 1 > 9 ? '' : '0') + (d.getMonth() + 1) 
			+ '-' + (d.getDate() > 9 ? '' : '0') +  d.getDate() + ' ' + (d.getHours() > 9 ? '' : '0') +  d.getHours() + ':' 
			+ (d.getMinutes() > 9 ? '' : '0') +  d.getMinutes() + ':'  + (d.getSeconds() > 9 ? '' : '0') +  d.getSeconds(),
		'formatted': '',
	};
	
	if (minsAgo < 60) { // 1시간 내
		result.formatted = minsAgo + '분 전';
	} else if (minsAgo < 60 * 24) { // 하루 내
		result.formatted = Math.floor(minsAgo / 60) + '시간 전';
	} else { // 하루 이상
		result.formatted = Math.floor(minsAgo / 60 / 24) + '일 전';
	};

	return result.formatted;
}