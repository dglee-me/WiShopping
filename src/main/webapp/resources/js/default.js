/* Common script*/

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
	var now = input.val();
	var price = parseInt(uncomma($('#price').text()),10);
		
	$.ajax({
		url : "/myapp/productions/view/checkOption",
		type : "post",
		data : {ono : ono},
		success : function(result){
			if(now > result){
				alert("선택한 수량이 재고보다 많습니다!");
				
				//Setting price and input value
				input.val(previous);				
				input.closest("article").children("div").children("p").children("span").text(comma(price * previous)+" ");//The reason for adding " " is because it splits above to compare option duplication.
			}
		}
	});
}

function productionOptionCheck(input,now){
	var ono = input.closest("article").children("h1").attr("data-number");
	var inventory;
	
	$.ajax({
		url : "/myapp/productions/view/checkOption",
		type : "post",
		async : false,
		data : {ono : ono},
		success : function(result){
			inventory = result;
		}
	});
	return inventory;
}