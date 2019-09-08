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
	
	//��Ʈ�ѷ��� ����Ǳ� ������ ���� ���� ��
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		// TODO Auto-generated method stub
		logger.info("-------- INTERCEPTOR ACCESS!!! --------");
		
		HttpSession session = request.getSession();
		//Login ó���� ����ϴ� ����� ������ ��ü�� �����´�
		Object obj = session.getAttribute("login");
		
		//�α��� ���� ���� Ȯ��
		if(obj == null) {
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			//Session������ ���� �� Cookie ������ Ȯ��
			if(loginCookie != null) {
				//Cookie���� SessionID ����
				String sessionId = loginCookie.getValue();
				//SessionId ������ �α��� ���� ����
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
	//��Ʈ�ѷ��� ����ǰ� �� �� ȭ���� �������� ������ �����
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception{
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
}
