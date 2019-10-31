$("#inputImg").change(function(){
	if(this.files && this.files[0]){
		var reader = new FileReader;
		reader.onload = function(data){
			$(".info_img_wrap img").attr("src", data.target.result).width(460);
		}
		reader.readAsDataURL(this.files[0]);
	}
});

$("#inputDetails").change(function(){
	if(this.files && this.files[0]){
		var reader = new FileReader;
		reader.onload = function(data){
			$(".deal_detailimg img").attr("src",data.target.result).width(758);
		}
		reader.readAsDataURL(this.files[0]);
	}
});