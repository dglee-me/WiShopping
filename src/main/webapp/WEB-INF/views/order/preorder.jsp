<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commerce.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?after">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script>
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
</script>

<title>위쇼핑! - 주문/결제</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="body" class="orders pre_order" style="padding-bottom:0px;">
		<div id="pre_order" class="bucket">
			<form id="edit_order" class="eidt_order" action="" method="post" accept-charset="UTF-8">
				<div id="title">주문/결제</div>
				<div class="panel">
					<div class="title">
						<div class="title">주문상품</div>
					</div>
					<table cellspacing="0" id="order_productions">
						<tbody>
							<tr class="production">
								<td>
									<div class="information">
										<img src="">
										<div>
											<div class="name">[리샘] 마틸다 구스다운 라텍스 헤드레스트 3인용 소파 2colors (쿠션증정)</div>
											<div class="option">머드그레이</div>
											<div class="cost_count">
												<div class="cost">1,533,000원</div>
												<div class="divider">|</div>
												<div class="count">7개</div>
											</div>
										</div>
									</div>
								</td>
								<td class="delivery_fee" data-id="">
									<div class="type">무료배송</div>
									<div class="seller">리샘가구</div>
								</td>
							</tr>
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
								<input type="text" name="recipient" id="order_recipient" class="non_edit can_copy half" readonly="readonly">
							</div>
						</div>
						<div class="field">
							<div class="label">우편번호</div>
							<div class="input">
								<input type="text" name="zipcode" id="order_received_zipcode" class="non_edit quarter" readonly="readonly">
								<a href="javascript:void(0);"><span id="select_address">배송지변경</span></a>
							</div>
						</div>
						<div class="field">
							<div class="label">주소</div>
							<div class="input vertical">
								<input type="text" name="received_at" id="order_received_at" class="non_edit full" readonly="readonly">
								<input type="text" name="received_at_detail" id="order_received_at_detail" class="non_edit full" readonly="readonly">
							</div>
						</div>
						<div class="field">
							<div class="label">휴대전화</div>
							<div class="input phone">
								<input type="text" name="received_phone" id="order_received_phone" class="non_edit">
							</div>
						</div>
						<div class="field">
							<div class="label">배송 메모</div>
							<div class="input vertical">
								<input type="text" name="delivery_message" id="delivery_message" class="delivery_memo full">
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
								<input type="text" name="payer_name" id="order_payer_name" class="half">
							</div>
						</div>
						<div class="field">
							<div class="label">이메일</div>
							<div class="input email">
								<input type="text" name="payer_email" id="order_payer_email" class="half">
							</div>
						</div>
						<div class="field">
							<div class="label">휴대전화</div>
							<div class="input phone">
								<input type="text" name="payer_phone" id="order_payer_phone" class="half">
							</div>
						</div>
					</div>
				</div>
				<div class="panel">
					<div class="title">
						<div class="title">최종 결제 금액</div>
					</div>
					<div class="cost">
						<div class="cost_panel">
							<div class="title">총 상품 금액</div>
							<div class="amount" id="preview_product_cost">1,950,000</div>
						</div>
						<div class="cost_panel">
							<div class="title">배송비</div>
							<div class="amount" id="preview_delivery_cost">0</div>
						</div>
						<div class="total cost_panel">
							<div class="amount" id="preview_selling_cost">1,950,000원</div>
						</div>
					</div>
				</div>
				<div class="panel">
					<div class="title">
						<div class="title">결제 수단</div>
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
			</form>
		</div>
	</div>
</body>
</html>