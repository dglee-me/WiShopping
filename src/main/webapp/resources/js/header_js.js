function bookmarksite(title,url){
	//IE
	if(document.all){
		window.external.AddFavorite(url,title);
	}
	//Google Chrome
	else if(window.chrome){
		alert("Ctrl+D키로 즐겨찾기에 추가하실 수 있습니다.");
	}
	else if(window.external){
		window.external.AddFavorite(url,title);
	}
}