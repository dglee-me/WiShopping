function bookmarksite(){
	//IE
	var agent = navigator.userAgent.toLowerCase();
	if((navigator.appName == "Netscape" && agent.indexOf("trident") != -1) || (agent.indexOf("msie") != -1)){
		window.external.AddFavorite("http://localhost:8081/myapp","위쇼핑");
	}
	//Google Chrome
	else if(window.chrome){
		alert("Ctrl+D키로 즐겨찾기에 추가하실 수 있습니다.");
	}
	else if(window.external){
		window.external.AddFavorite(url,title);
	}
}
