<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<html lang="ko">
<head>
	<script type="text/javascript">
		var detail_image_count = 0;
		
		$(document).on("click",".btn_add",function(e){
			e.preventDefault();
			
			$(this).parent().children("input:file[class='product-register-image']").click();
		});
		
		$(document).on("change",".product-register-image",function(){
			if($(this).attr("id") == "product-register-thumb-image"){//썸네일인 경우
				if(this.files && this.files[0]){
			        document.getElementById("product-register-image-empty").style.display = "none";
			        document.getElementById("product-register-image-exist").style.display = "block";
					
					var reader = new FileReader;
					reader.onload = function(data){
						$(".thumb img").attr("src", data.target.result).width(460);
						$(".thumb img").height(460);
					}
					reader.readAsDataURL(this.files[0]);
				}
			}else{//썸네일이 아닌 상세이미지인 경우
				if(detail_image_count < 5){//상세 이미지가 5장이하까지만 이미지 등록 가능
					detail_image_count += 1;
					$("#product-register-detail-image-count").text(detail_image_count);
					
					if(this.files && this.files[0]){
						$(".btn_add").remove(); //기존의 btn_add 삭제
						
						//새로운 btn_add div 생성
						var listParent = $(this).closest("ul");
						var listChildren = document.createElement("li");
						listChildren.className = "product-register-addimage-sortable";
						
						listChildren.innerHTML =
							"<div class='list-thumb-small image-small'>"
							+"<div class='info_box btn_add'>등록"
							+"</div>"
							+"<input type='file' name='product_url' class='product-register-image'>"
							+"</div>";
						
						listParent.append(listChildren);
						
						//기존의 btn_add 자리에 이미지 보여주는 div 생성
						listParent = $(this).closest("div");
						listChildren = document.createElement("div");
						listChildren.className = "list-thumb-small image-small border";
						
						var reader = new FileReader;
						reader.onload = function(data){
							listChildren.innerHTML = "<img src='"+data.target.result+"' class='product-register-add-image-tag'>";
							listParent.prepend(listChildren);
						}
						reader.readAsDataURL(this.files[0]);							
					}
				}else{
					if(this.files && this.files[0]){
						alert("5장까지만 추가할 수 있습니다.");
					}
				}
			}
		});
		
		$(document).ready(function(){
	         $(".main_category").change(function(){
	            var fashion = ["아우터","상의","하의","신발","가방","잡화"];
	            var accessories = ["가방","지갑","벨트","안경테/선글라스","양말/스타킹","패션 잡화/소품"];
	            var interior = ["가구","침구","조명·인테리어"];
	            var digital = ["대형가전","주방가전","컴퓨터·태블릿","음향가전","디지털·휴대폰·카메라"];
	            
	            var selectItem = $(".main_category").val();
	            var changeItem;
	            
	            if(selectItem == "패션"){
	               changeItem = fashion;
	            }else if(selectItem == "잡화"){
	               changeItem = accessories;
	            }else if(selectItem == "인테리어"){
	               changeItem = interior;
	            }else if(selectItem == "가전·디지털"){
	               changeItem = digital;
	            }else{
	               changeItem = ["중분류"];
	            }
	            
	            $(".sub_category").empty();
	            
	            for(var i=0;i<changeItem.length;i++){
	               var option = $("<option>"+changeItem[i]+"</option>");
	               $(".sub_category").append(option);
				}
			});
		});

		$(document).on("change",".fcheck",function(){
	        var checked = $(this).val();
	        
	        if(checked == "T"){
	           document.getElementById("option_btn").style.display = "block";
	           document.getElementById("product-register-option-area").style.display = "table-row";
	           document.getElementById("product-register-option-area_default").style.display = "none";
	           document.getElementById("defaultcolor").name="none";
	           document.getElementById("defaultsize").name="none";
	           document.getElementById("defaultinventory").name="none";
	           
	        }else{
	           document.getElementById("option_btn").style.display = "none";
	           document.getElementById("product-register-option-area").style.display = "none";
	           document.getElementById("product-register-option-area_default").style.display = "table-row";
	           document.getElementById("defaultcolor").name="optioncolor";
	           document.getElementById("defaultsize").name="optionsize";
	           document.getElementById("defaultinventory").name="inventory";
	           
	        }
	     });
		
		/*
		//상품 옵션 생성
		$(document).ready(function(){
			$("#option_btn").click(function(){
				var option_color = $("#option_color").val().split(";");
				var option_size = $("#option_size").val().split(";");

				//Create option color input for sending to the controller
				for(var i=0;i<option_color.length;i++){
					if(option_color[i] == "") continue;
					
					var input_option = document.createElement("input");

					input_option.type = "hidden";
					input_option.name = "optioncolor";
					input_option.value = option_color[i];
					
					$(".option-row_color").append(input_option);
				}
				
				//Create option size input for sending to the controller
				for(var i=0;i<option_size.length;i++){
					if(option_size[i] == "") continue;
					
					var input_option = document.createElement("input");

					input_option.type = "hidden";
					input_option.name = "optionsize";
					input_option.value = option_size[i];
					
					$(".option-row_color").append(input_option);
				}
				
				//Create options by combining color and size
				if(option_color == "" || option_size == ""){
					alert("색상 및 사이즈를 모두 입력하여주세요.");
					
					if(option_color == ""){
						$("#option_color").focus();
					}else{
						$("#option_size").focus();
					}
				}else{
					for(var i=0;i<option_color.length;i++){// color x size value 
						if(option_color[i] == "") continue;
						for(var j=0;j<option_size.length;j++){
							if(option_size[j] == "") continue;
							
							var createRow = document.createElement("tr");
							createRow.className = "product-register-item-rows";
							createRow.setAttribute("data-item-value",option_color[i]+"/"+option_size[j]);
							
							createRow.innerHTML = "<td><span class='product-register-item-list-option_name'>"+option_color[i]+"/"+option_size[j]+"</span></td>"
								+"<td></td>"
								+"<td><input type='text' class='ftext right' style='width:100%;' name='inventory' value='0'></td>"
								+"<td><a href='javascript:void(0);' class='btnApply btn_delete product-register-item-list-delete'><em class='icoDel'></em>삭제</a></td>";

							$("#product-register-item-list").append(createRow);
							
							$("#option_color").val("");
							$("#option_size").val("");
						}	
					}
				}
			});
		});
		*/
		
		//상품 옵션 생성
		$(document).ready(function(){
			$("#option_btn").click(function(){
				var option_color = $("#option_color").val().split(";");
				var option_size = $("#option_size").val().split(";");
				if(option_color == "" || option_size == ""){
					alert("색상 및 사이즈를 모두 입력하여주세요.");
					
					if(option_color == ""){
						$("#option_color").focus();
					}else{
						$("#option_size").focus();
					}
				}else{
					for(var i=0;i<option_color.length;i++){
						for(var j=0;j<option_size.length;j++){
							if(option_color[i] == "" || option_size[j] == "") continue;
							
							var input_option = document.createElement("input");
							input_option.type = "hidden";
							input_option.name = "optioncolor";
							input_option.value = option_color[i]+"#$%"+option_size[j];

							$(".option-row_color").append(input_option);
						}
					}
					
					for(var i=0;i<option_color.length;i++){
						for(var j=0;j<option_size.length;j++){
							if(option_color[i] == "" || option_size[j] == "") continue;
							
							var createRow = document.createElement("tr");
							createRow.className = "product-register-item-rows";
							createRow.setAttribute("data-item-value",option_color[i]+"/"+option_size[j]);
							createRow.innerHTML = "<td><span class='product-register-item-list-option_name'>"+option_color[i]+"/"+option_size[j]+"</span></td>"
							+"<td></td>"
							+"<td><input type='text' class='ftext right' style='width:100%;' name='inventory' value='0'></td>"
							+"<td><a href='javascript:void(0);' class='btnApply btn_delete product-register-item-list-delete'><em class='icoDel'></em>삭제</a></td>";

							$("#product-register-item-list").append(createRow);
						}
					}
					
					$("#option_color").val("");
					$("#option_size").val("");
				}
			});
		});
		
		
		$(document).ready(function(){
			$("#delivery-fee-type").change(function(){
				var delivery = $("#delivery-fee-type").val();
				if(delivery != 0){
			    	document.getElementById("delivery-fee-row").style.display = "table-row";
				}else{
			    	document.getElementById("delivery-fee-row").style.display = "none";
				}
			});
		});
		
		$(document).ready(function(){
			$(".button_box").click(function(){
				//Validate before product regist
				var pname = $("#pname").val();
				var thumbnail = $("#product-register-thumb-image").val();
				var price = $("#price").val();
				var category1 = $(".main_category").val();
				var category2 = $(".sub_category").val();
				var detail = $("#product-register-detail-image").val();
				var optioncolor = $("input:text[name='optioncolor']").val();
				var optionsize = $("input:text[name='optionsize']").val();
				var inventory = $("input:text[name='inventory']").val();
				
				if(pname == "" || thumbnail == "" || price == "" || category1 == "" || category2 == "" || detail == "" || 
						optioncolor == "" || optionsize == "" || inventory == ""){
					alert("입력 항목을 모두 입력하여주세요.");
				}else{
					document.getElementById('frm').submit();
				}
			});
		});
		
		//Delete select option
		$(document).on("click",".btn_delete",function(){
			var selected = $(this).closest("tr").attr("data-item-value");
			selected = selected.split("/");
			
			var input_list = $("input[name='optioncolor']");

			$.each(input_list,function(){
				var temp = $(this).val().split("#$%");
				
				if(selected[0] == temp[0] && selected[1] == temp[1]){
					$(this).remove();
					
					return false;
				}
			});
			
			$(this).closest("tr").remove();
		});
	</script>
	<meta charset="UTF-8">
	<title>글쓰기</title>
</head>
<body>
	<div class="layout">
		<jsp:include page="../header.jsp"/>
		<div class="container-wrap">
			<h2 class="hide">상품 등록</h2>
			<div class="container_inner">
				<div class="contents_wrap">
					<form method="post" id="frm" action="regist" enctype="multipart/form-data">
					<div class="content_regist">
						<div class="category_nav">
							<div class="inner">
								<div class="nav">
									<ul>
										<li><a href="${pageContext.request.contextPath}">홈</a></li>
										<li><a href="${pageContext.request.contextPath}/admin/main">관리자 홈</a></li>
										<li><a href="javascript:void(0);">상품관리</a></li>
										<li class="now"><a href="javascript:void(0);">상품 등록</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="content_main">
							<div class="headerTitle">
								<h1>상품 등록</h1>
							</div>
							<div class="bar product-register-bar">
								<h2>기본 정보</h2>
							</div>
							<div class="bar-Area">
								<!-- 이미지 등록 전 -->
								<div class="info_box image-large" id="product-register-image-empty">
									<div class="btn_add">등록</div>
									<!-- 이미지 업로드 -->
									<input type="file" name="product_thumurl" class="product-register-image" id="product-register-thumb-image">
									<input type="hidden" name="brand" value="${login.name}">
								</div>
								<!-- 이미지 등록 후 -->
								<div class="info_box image-large" id="product-register-image-exist" style="display:none;">
									<div class="thumb">
										<img src="" alt id="product-register-image">
									</div>
								</div>
								<table border="1" summary>
									<label class="hide">상품 기본 정보</label>
									<colgroup>
										<col style="width:150px;">
										<col style="width:422px;">
										<col style="width:auto;">
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">상품명</th>
											<td>
												<span class="formRequired">
													<input type="text" name="pname" required="required" id="pname" class="fText" placeholder="예시) U넥 반팔 티셔츠" style="width:100%;">
												</span>
											</td>
										</tr>
										<tr>
											<th scope="row">가격</th>
											<td>
												<span class="formRequired">
													<input type="text" name="price" required="required" id="price" class="right fText" style="width:150px;" value="0">
													원
												</span>
											</td>
										</tr>
										<tr>
											<th scope="row">상품분류</th>
											<td>
												<nav class="product_selling_category">
													<ul>
														<li class="commerce-category-list">
															<select class="category main_category" name="category1">
																<option value="">대분류</option>
																<option value="패션">패션</option>
																<option value="잡화">잡화</option>
																<option value="인테리어">인테리어</option>
																<option value="가전·디지털">가전·디지털</option>
															</select>
														</li>
														<li class="commerce-category-list">
															<select class="category sub_category" name="category2">
																<option value="">중분류</option>
															</select>
														</li>
													</ul>
												</nav>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="info_product wrap_button">
	                            	<div class="button_box">
	                                	<a href="javascript:void(0);" class="btn_sys red_big_xb bui"><span>등록하기</span></a>
	                                </div>
	                            </div>
							</div>
							<div class="bar product-register-bar">
								<h2>상세 설명</h2>
							</div>
							<div class="bar-Area">
								<table border="1" summary>
									<h2 class="hide">상세설명</h2>
									<colgroup>
										<col style="width: 150px;">
										<col style="width: 870px;">
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">이미지</th>
											<td style="padding:10px 0 0 10px;">
												<span class="txt_strong" style="margin-left:10px;">상세이미지</span>
												<span class="txt_byte">[<strong id="product-register-detail-image-count">0</strong>/5]</span>
												<div class="thumbs">
													<ul id="extraImage">
														<li class="product-register-addimage-sortable">
															<div class="list-thumb-small image-small">
																<div class="info_box btn_add">등록</div>
																<input type="file" name="product_url" class="product-register-image" id="product-register-detail-image">
															</div>
														</li>
													</ul>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="bar product-register-bar">
								<h2>옵션 설정</h2>
							</div>
							<div class="bar-Area">
								<div class="typeWrite">
									<table border="1" summary>
										<h2 class="hide">옵션설정</h2>
										<colgroup>
											<col style="width:150px;">
											<col style="width:870px;">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row">상품옵션</th>
												<td>
													<label class="flabel">사용함
														<input type="radio" class="fcheck eMarketChecker" value="T" id="eOptionUseT" name="has_option">
														<span class="checkMark"></span>
													</label>
													<label class="flabel">사용안함
														<input type="radio" class="fcheck" value="F" name="has_option" checked="checked">
														<span class="checkMark"></span>
													</label>
													<button type="button" id="option_btn" style="display:none;">옵션 만들기</button>
												</td>
											</tr>
											<tr id="product-register-option-area" style="display:none;"> 
												<th scope="row">옵션설정</th>
												<td>
													<div class="option_first">
														<table border="1" summary>
															<h2 class="hide">옵션세트</h2>
															<colgroup>
																<col style="width:170px;">
																<col style="width:600px;">
															</colgroup>
															<thead>
																<tr>
																	<th scope="col">옵션명</th>
																	<th scope="col">옵션값</th>
																</tr>
															</thead>
															<tbody id="optionBody">
																<tr class="option-row option-row_color">
																	<td style="text-align:center;">색상</td>
																	<td>
																		<div class="option_value_area">
																			<div class="box">
																				<input type="text" class="option_color_value" id="option_color" name="option_color">
																				<p class="txtInfo"> - 세미콜론(;)을 통해 옵션값을 구분하여 연속적으로 입력하세요.</p>
																			</div>
																		</div>
																	</td>
																</tr>
																<tr class="option-row option-row_size">
																	<td style="text-align:center;">사이즈</td>
																	<td>
																		<div class="option_value_area">
																			<div class="box">
																				<input type="text" class="option_size_value" id="option_size" name="option_color">
																				<p class="txtInfo"> - 세미콜론(;)을 통해 옵션값을 구분하여 연속적으로 입력하세요.</p>
																			</div>
																		</div>
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
													<div>
														<div class="option_board_Area">
															<div class="typehead">
																<table border="1" summary>
																	<h2 class="hide">옵션품목</h2>
																	<colgroup>
									                                    <col style="width:305px;">
									                                    <col style="width:155px">
									                                    <col style="width:155px">
									                                    <col style="width:155px;">
									                                </colgroup>
									                                <tbody>
									                                	<tr>
									                                		<th scope="col">옵션</th>
									                                		<th scope="col">비고</th>
									                                		<th scope="col">수량</th>
									                                		<th scope="col">삭제</th>
									                                	</tr>
									                                </tbody>
																</table>
															</div>
															<div class="typebody">
																<table border="1" summary>
																	<h2 class="hide">옵션품목</h2>
																	<colgroup>
									                                    <col style="width:305px;">
									                                    <col style="width:155px">
									                                    <col style="width:155px">
									                                    <col style="width:155px;">
									                                </colgroup>
									                                <tbody id="product-register-item-list">
									                                	<tr class="positive">
									                                		<td class="right"><strong class="txt_strong">일괄 적용</strong></td>
									                                		<td></td>
									                                		<td><input type="text" class="ftext right" style="width:100%;" value="0"></td>
									                                		<td><a href="javascript:void(0);" class="btnApply" id="product-register-item-batch-apply">일괄 적용</a></td>
									                                	</tr>
									                                </tbody>
																</table>
															</div>
														</div>
													</div>
												</td>
											</tr>
											<tr id="product-register-option-area_default">
												<th scope="row">기본옵션</th>
												<td>
													<span class="formRequired">
														색상 <input type="text" name="optioncolor" id="defaultcolor" class="fText" placeholder="ex) 블랙" style="border:1px solid #ededed; margin-right:20px;">
														사이즈 <input type="text" name="optionsize" id="defaultsize" class="fText" placeholder="ex) free" style="border:1px solid #ededed; margin-right:20px;">
														수량 <input type="text" name="inventory" id="defaultinventory" class="fText" placeholder="ex) 1" style="border:1px solid #ededed;">
													</span>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="bar product-register-bar">
								<h2>배송정보</h2>
							</div>
							<div class="bar-Area">
								<div class="typeWrite">
									<table border="1" summary>
										<h2 class="hide">배송정보</h2>
										<colgroup>
											<col style="width:150px;">
											<col style="width:870px;">
										</colgroup>
										<tbody>
											<tr class="delivery-shipping-area">
												<th scope="row">
													배송기간
												</th>
												<td>
													약<select class="category" name="shippingday">
														<option value="1">1</option>
														<option value="2">2</option>
														<option value="3" selected>3</option>
														<option value="4">4</option>
														<option value="5">5</option>
														<option value="6">6</option>
														<option value="7">7</option>
													</select> 일 소요됩니다.
												</td>
											</tr>
											<tr class="delivery-shipping-area">
												<th scope="row">
													배송비
												</th>
												<td>
													<select class="category" id="delivery-fee-type" name="shipping" style="width:100px;">
														<option value="0">배송비 무료</option>
														<option value="1">배송비 설정</option>
													</select>
												</td>
											</tr>
											<tr id="delivery-fee-row" style="display:none;">
												<th scope="row">배송비 상세 설정</th>
												<td id="delivery-fee-content">
													<span id="delivery-shipfee-grade" class="delivery-shipfee-grade-hidden">
														배송비 <input type="text" class="ftext right" style="width:100px; border:1px solid #ededed;" name="shipping_fee" value="0"> 원을 부과합니다.
													</span>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>						
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
		<jsp:include page="../footer.jsp"/>
	</div>
</body>
</html>