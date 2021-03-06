<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">

<!-- Daum Address API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/default.js"></script>

<!-- Import 'iamport'  -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	//Login session confirm
	$(document).ready(function(){
		var session = "${login.name}";
		
		if(session == ""){
			alert("로그인 후 이용하여 주세요.");
			location.href="/WiShopping/auth/login";
		}
	});
	
	//If the products are the same, set rowspan the shipping td
	$(document).ready(function(){
		tableRowSpanning("#order_productions",1);
	});
	
	//All price setting
	$(document).ready(function(){
		//Total product price setting
		var price = $(".cost").text();
		price = price.split("원");

		var total_price = 0;
		for(var i=0;i<price.length;i++){
			if(price[i] == "") continue;
			total_price += parseInt(uncomma(price[i]),10);
		}
		
		$("#preview_product_cost").text(comma(total_price));
		
		//Total delivery fee setting
		var delivery = $(".type").text();
		delivery = delivery.split("원");
		
		var total_delivery = 0;
		for(var i=0; i<delivery.length;i++){
			delivery[i] = parseInt(uncomma(delivery[i]),10);
			
			if(isNaN(delivery[i])) continue;
			
			total_delivery += delivery[i];
		}
		
		$("#preview_delivery_cost").text(comma(total_delivery));
		
		//Total payment setting
		$("#preview_selling_cost").text(comma(total_price + total_delivery)+"원")
		$("input:hidden[name='amount']").val(total_price + total_delivery);
	});
	
	$(document).ready(function(){	
		$(".opener").click(function(){
			if($(this).text() == "보기"){
				$(this).text("닫기");
				$(this).parent().next().css({"display":"block"});
			}else if($(this).text() == "닫기"){
				$(this).text("보기");
				$(this).parent().next().css({"display":"none"});
			}else if($(this).text() == "열기"){
				console.log("아직 미구현^^;;");
			}
		});
	});
	
	$(document).ready(function(){
		$("#copy_delivery").click(function(){
			$("#order_payer_name").val($("#order_recipient").val());
			$("#order_payer_phone").val($("#order_received_phone").val());
		});
	});
	
	/*
	$(document).ready(function(){
		$("#do_payment").click(function(){
			var orderrec = $("input:text[name='orderrec']").val();
			var zipcode = $("input:text[name='zipcode']").val();
			var received_at = $("input:text[name='receivedat']").val();
			var received_at_detail = $("input:text[name='receivedatdetail']").val();
			var received_phone = $("input:text[name='receivedphone']").val();
			
			var payer_name = $("input:text[name='payername']").val();
			var payer_email = $("input:text[name='payeremail']").val();
			var payer_phone = $("input:text[name='payerphone']").val();
			
			if(orderrec == "" || zipcode == "" || received_at == "" || received_at_detail == "" || received_phone == "" 
					|| payer_name == "" || payer_email == "" || payer_phone == ""){
				alert("입력 사항을 모두 입력하여주세요.");
			}else{
				var checked = $("#check_agree_policy");
				
				if(checked[0].checked == true){	
					document.order_frm.submit();
				}else{
					alert("결제 진행 필수사항에 동의해주세요.");
				}
			}
			
		});
	});
	*/
	
	$(document).ready(function(){
		$("#do_payment").click(function(){
			var orderrec = $("input:text[name='orderrec']").val();
			var zipcode = $("input:text[name='zipcode']").val();
			var received_at = $("input:text[name='receivedat']").val();
			var received_at_detail = $("input:text[name='receivedatdetail']").val();
			var received_phone = $("input:text[name='receivedphone']").val();
			
			var payer_name = $("input:text[name='payername']").val();
			var payer_email = $("input:text[name='payeremail']").val();
			var payer_phone = $("input:text[name='payerphone']").val();
			
			var amount = parseInt(uncomma($("#preview_selling_cost").text()),10);
			
			if(orderrec == "" || zipcode == "" || received_at == "" || received_at_detail == "" || received_phone == "" || payer_name == "" 
					|| payer_email == "" || payer_phone == ""){
				alert("입력 사항을 모두 입력하여주세요.");
			}else{
				var checked = $("#check_agree_policy");
				
				if(checked[0].checked == true){	
					var payment = $("input[name='order[payment_method]']:checked").attr("id");
					
					if(payment == "order_payment_method_credit_card"){
						IMP.init("imp00584928");
						
						IMP.request_pay({
						    pg : 'html5_inicis',
						    pay_method : 'card',
						    merchant_uid : 'merchant_' + new Date().getTime(),
						    name : '위쇼핑',
						    amount : amount,
						    buyer_email : payer_email,
						    buyer_name : payer_name,
						    buyer_tel : payer_phone,
						    buyer_addr : received_at + received_at_detail,
						    buyer_postcode : zipcode
						}, function(rsp) {
						    if ( rsp.success ) {
						        var msg = "결제가 완료되었습니다.";
						        msg += "\n고유ID : " + rsp.imp_uid;
						        msg += "\n상점 거래ID : " + rsp.merchant_uid;
						        msg += "\n결제 금액 : " + rsp.paid_amount;
						        msg += "\n카드 승인번호 : " + rsp.apply_num;
						    } else {
						        var msg = "결제에 실패하였습니다.\n";
						        msg += '에러내용 : ' + rsp.error_msg;
						    }

						    alert(msg);
						    
						    if(rsp.success){
						    	document.order_frm.submit();
						    }
						});
					}
				}else{
					alert("결제 진행 필수사항에 동의해주세요.");
				}
			}
		});
	});
</script>

<title>위쇼핑! - 주문/결제</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="body" class="orders pre_order" style="padding-bottom:0px;">
		<div id="pre_order" class="bucket">
			<form id="edit_order" class="eidt_order" name="order_frm" action="pre_order" method="post" accept-charset="UTF-8">
				<div id="title">주문/결제</div>
				<div class="panel">
					<div class="title">
						<div class="title">주문상품</div>
					</div>
					<table cellspacing="0" id="order_productions">
						<tbody>
							<c:forEach var="item" items="${orderList}">	
								<c:set var="amount" value="${amount + (item.price * item.inventory)}"/>
								<tr class="production" data-number="${item.pno}">
									<input type="hidden" name="pno" value="${item.pno}">
									<input type="hidden" name="ono" value="${item.ono}">
									<input type="hidden" name="inventory" value="${item.inventory}">
									<input type="hidden" name="cartno" value="${item.cartno}">
									<td>
										<div class="information">
											<img src="${pageContext.request.contextPath}/${item.productthumurl}">
											<div>
												<div class="name">[${item.brand}] ${item.pname}</div>
												<div class="option">${item.optioncolor}/${item.optionsize}</div>
												<div class="cost_count">
													<div class="cost"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.price * item.inventory}"/>원</div>
													<div class="divider">|</div>
													<div class="count">${item.inventory}개</div>
												</div>
											</div>
										</div>
									</td>
									<td class="delivery_fee" data-number="${item.pno}">
										<div class="type">
											<c:if test="${item.shippingfee eq 0 }">무료배송 </c:if>
											<c:if test="${item.shippingfee ne 0 }">
												<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.shippingfee}"/>원 
											</c:if>
										</div>
										<div class="seller">${item.brand}</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="panel">
					<div class="title">
						<div class="title">배송지</div>
					</div>
					<div class="input">
						<div class="field">
							<div class="label">받는분</div>
							<div class="input">
								<input type="text" name="orderrec" id="order_recipient" class="can_copy half">
							</div>
						</div>
						<div class="field">
							<div class="label">우편번호</div>
							<div class="input">
								<input type="text" name="zipcode" id="order_received_zipcode" class="non_edit quarter" readonly="readonly">
								<%--<c:if test=""><a href="javascript:void(0);"><span id="select_address">배송지변경</span></a></c:if> --%>
								<a href="javascript:void(0);" onclick="sample2_execDaumPostcode()"><span id="find_address">우편번호</span></a>
								<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
								<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
								<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
								</div>
								<script>
									// 우편번호 찾기 화면을 넣을 element
								    var element_layer = document.getElementById('layer');
	
								    function closeDaumPostcode() {
								        // iframe을 넣은 element를 안보이게 한다.
								        element_layer.style.display = 'none';
								    }
								    
								    function sample2_execDaumPostcode() {
								        new daum.Postcode({
								            oncomplete: function(data) {
								                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

								                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
								                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
								                var addr = ''; // 주소 변수
								                var extraAddr = ''; // 참고항목 변수

								                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
								                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								                    addr = data.roadAddress;
								                } else { // 사용자가 지번 주소를 선택했을 경우(J)
								                    addr = data.jibunAddress;
								                }
								                
								                // 우편번호와 주소 정보를 해당 필드에 넣는다.
								                document.getElementById('order_received_zipcode').value = data.zonecode;
								                document.getElementById("order_received_at").value = addr;
								                // 커서를 상세주소 필드로 이동한다.
								                document.getElementById("order_received_at_detail").focus();

								                // iframe을 넣은 element를 안보이게 한다.
								                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
								                element_layer.style.display = 'none';
								            },
								            width : '100%',
								            height : '100%',
								            maxSuggestItems : 5
								        }).embed(element_layer);

								        // iframe을 넣은 element를 보이게 한다.
								        element_layer.style.display = 'block';

								        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
								        initLayerPosition();
								    }

								    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
								    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
								    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
								    function initLayerPosition(){
								        var width = 300; //우편번호서비스가 들어갈 element의 width
								        var height = 400; //우편번호서비스가 들어갈 element의 height
								        var borderWidth = 5; //샘플에서 사용하는 border의 두께

								        // 위에서 선언한 값들을 실제 element에 넣는다.
								        element_layer.style.width = width + 'px';
								        element_layer.style.height = height + 'px';
								        element_layer.style.border = borderWidth + 'px solid';
								        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
								        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
								        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
								    }
								</script>
							</div>
						</div>
						<div class="field">
							<div class="label">주소</div>
							<div class="input vertical">
								<input type="text" name="receivedat" id="order_received_at" class="non_edit full" readonly="readonly">
								<input type="text" name="receivedatdetail" id="order_received_at_detail" class="full">
							</div>
						</div>
						<div class="field">
							<div class="label">휴대전화</div>
							<div class="input phone">
								<input type="text" name="receivedphone" id="order_received_phone" class>
							</div>
						</div>
						<div class="field">
							<div class="label">배송 메모</div>
							<div class="input vertical">
								<input type="text" name="deliverymessage" id="delivery_message" class="delivery_memo full">
								<div id="delivery_alert">OO자 이하로 입력해주세요!</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel">
					<div class="title">
						<div class="title">주문자</div>
						<div class="button" id="copy_delivery">배송지 정보로 채우기</div>
					</div>
					<div class="input">
						<div class="field">
							<div class="label">이름</div>
							<div class="input">
								<input type="text" name="payername" id="order_payer_name" class="half" value="${login.name}">
							</div>
						</div>
						<div class="field">
							<div class="label">이메일</div>
							<div class="input email">
								<input type="text" name="payeremail" id="order_payer_email" class="half" value="${login.email}">
							</div>
						</div>
						<div class="field">
							<div class="label">휴대전화</div>
							<div class="input phone">
								<input type="text" name="payerphone" id="order_payer_phone" class="half" value="${login.tel}">
							</div>
						</div>
					</div>
				</div>
				<div class="panel">
					<div class="title">
						<div class="title">최종 결제 금액</div>
					</div>
					<div class="all_cost">
						<div class="cost_panel">
							<div class="title">총 상품 금액</div>
							<div class="amount" id="preview_product_cost">0</div>
						</div>
						<div class="cost_panel">
							<div class="title">할인 금액</div>
							<div class="amount" id="preview_discount_cost">0</div>
						</div>
						<div class="cost_panel">
							<div class="title">배송비</div>
							<div class="amount" id="preview_delivery_cost">0</div>
						</div>
						<div class="total cost_panel">
							<div class="amount" id="preview_selling_cost">0원</div>
						</div>
					</div>
				</div>
				<div class="panel">
					<div class="title">결제 수단</div>
					<div class="pay_method">
						<div class="payment_panel">
							<input type="radio" value="credit_card" name="order[payment_method]" id="order_payment_method_credit_card" checked="checked">
							<label class="first top" for="order_payment_method_credit_card">
				            	<img class="img" width="64" src="https://bucketplace-v2-development.s3.amazonaws.com/pg/card.png" alt="Card">
				                <div class="title">카드</div>
							</label>
						</div>
					</div>
				</div>
				<div id="confirm_checkbox">
					<div class="form-check check_agree_policy">
						<label class="form-check-label" for="check_agree_policy">
				        	<input type="checkbox" id="check_agree_policy" class="form-check">
				        	<span class="check-img"></span>
				        	결제 진행 필수사항 동의
				        </label>
					</div>
					<div class="all_policy">
						<div class="title">개인정보 제 3자 제공 및 결제대행 서비스 표준 이용약관</div>
						<div class="opener">보기</div>
					</div>
					<div class="policies" style="display:none;">
						<div class="policy">
							<div class="title_panel">
								<div class="title">개인정보 제 3자 제공</div>
								<div class="opener">열기</div>
							</div>
						</div>
						<div class="policy">
							<div class="title_panel">
								<div class="title">개인정보 수집 및 이용</div>
								<div class="opener">열기</div>
							</div>
						</div>
					</div>
				</div>
				<div id="do_payment">결제하기</div>
				<input type="hidden" name="amount" value="0">
				<script>
					//Item session confirm
					$(document).ready(function(){
						var session = "${amount}";
						
						if(session == ""){
							alert("세션이 만료되었습니다. 다시 시도해주세요.");
							history.go(-1);
						}
					});
				</script>
			</form>
		</div>
	</div>
</body>
</html>