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