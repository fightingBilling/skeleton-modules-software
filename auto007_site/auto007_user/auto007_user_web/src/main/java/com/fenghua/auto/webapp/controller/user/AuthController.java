package com.fenghua.auto.webapp.controller.user;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fenghua.auto.backend.core.utils.MessageHelper;
import com.fenghua.auto.backend.domain.user.User;
import com.fenghua.auto.backend.service.user.AuthService;
import com.fenghua.auto.backend.service.user.UserService;
import com.qq.connect.QQConnectException;
import com.qq.connect.oauth.Oauth;

/**
 * 第三方账号授权
 * 
 * @author zhangfr
 *
 */
@Controller
@RequestMapping("/auth")
public class AuthController {
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	@Autowired
	private UserService userService;
	@Autowired
	private AuthService authService;
	/**
	 * 跳转到qq授权页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/qq")
	public String qqAuth(HttpServletRequest request) {
		String qqUrl = null;
		try {
			qqUrl = new Oauth().getAuthorizeURL(request);
		} catch (QQConnectException e) {
			e.printStackTrace();
		}
		return "redirect:" + qqUrl;
	}
	/**
	 * qq登陆授权后回掉地址
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/qqafterlogin")
	public ModelAndView afterlogin(HttpServletRequest request) {
		try {
			User user=authService.hasUser(request);
			return URL(request,user);
		} catch (QQConnectException e) {
			e.printStackTrace();
			return new ModelAndView("web.login");
		}
	}
	/**
	 * 跳转到微信登陆页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/weixin")
	public String weixinAuth(HttpServletRequest request) {
		String weixinURL=authService.getWeiXinURL(request);
		return "redirect:" + weixinURL;
	}
	/**
	 * 微信回掉地址
	 * @param request
	 * @param code
	 * @param state
	 * @param openid
	 * @return
	 */
	@RequestMapping("/weixinAafterlogin")
	public ModelAndView weixinAafterlogin(HttpServletRequest request,String code,String state,String openid ) {
		String sessionState=(String)request.getSession().getAttribute(authService.WEIXIN_STATE);
		ModelAndView mv=new ModelAndView("web.login");
		if((code==null&&openid==null)||sessionState==null){
			mv.addObject("message",MessageHelper.getMessage("login.anth.erro"));
			logger.debug("(程序错误)微信登陆逻辑异常！");
			return mv;
		}else if(openid!=null){
			logger.debug("第二次请求weixinAafterlogin+22222222222222+");
			request.getSession().setAttribute("WeChatOpenid", openid);
			User user=userService.getUserByWeChat(openid);
			return URL(request,user);
		}else if(!sessionState.equals(state)){
			mv.addObject("message",MessageHelper.getMessage("login.anth.erro"));
			logger.debug("跨站请求伪造攻击!!");
			return mv;
		}else{
			logger.debug("第一次请求weixinAafterlogin+1111111111111+");
			String WeiXinOpenIDURL =authService.getWeiXinOpenIDURL(code);
			return new ModelAndView("redirect:"+WeiXinOpenIDURL);
		}
	}
	
	/**
	 * 根据判断user是否存在，存在则跳转到主页并登录
	 * 否则跳转到绑定账号页面页面
	 * @param request
	 * @param user
	 * @return
	 */
	private ModelAndView URL(HttpServletRequest request,User user){
		if(user!=null){
			//登陆
			userService.autoLogin(user.getName(), user.getPassword(), request);
			//跳转到首页
			return new ModelAndView("web.index_view");
		}else {
			//跳转到注册页面
			return new ModelAndView("web.bindingUser");
		}
	}
}
