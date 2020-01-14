package com.lee.myapp.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.lee.myapp.domain.MemberVO;
import com.lee.myapp.service.MemberService;
import com.sun.istack.internal.logging.Logger;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Inject
	MemberService memberService;

	//컨트롤러가 실행되기 이전에 먼저 수행 됨
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		// TODO Auto-generated method stub
		logger.info("-------- INTERCEPTOR ACCESS!!! --------");
		
		HttpSession session = request.getSession();
		//Login 처리를 담당하는 사용자 정보의 객체를 가져온다
		Object obj = session.getAttribute("login");

		//로그인 상태 여부 확인
		if(obj == null) {
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			//Session정보가 없을 시 Cookie 정보를 확인
			if(loginCookie != null) {
				//Cookie에서 SessionID 추출
				String sessionId = loginCookie.getValue();
				//SessionId 값으로 로그인 정보 추출
				MemberVO memberVO = memberService.checkUserWithSessionKey(sessionId);
				
				if(memberVO != null) {
					session.setAttribute("login", memberVO);
					return true;
				}else {
					response.sendRedirect(request.getContextPath()+"/auth/login");
					return false;
				}
			}
		}
		return true;
	}
	//컨트롤러가 실행되고 난 후 화면이 보여지기 직전에 수행됨
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception{
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
}
