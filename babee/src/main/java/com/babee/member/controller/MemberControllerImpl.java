package com.babee.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.babee.common.base.BaseController;
import com.babee.member.service.MemberService;
import com.babee.member.vo.MemberVO;
import com.babee.seller.service.SellerService;
import com.babee.seller.vo.SellerVO;



@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl extends BaseController implements MemberController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private SellerService sellerService;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private SellerVO sellerVO;
	
	@Override
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		 memberVO=memberService.login(loginMap);
		 sellerVO=sellerService.login(loginMap);
		
		 HttpSession session=request.getSession();
			session=request.getSession();
		if(memberVO != null){
			session.setAttribute("isLogOn", true);
			session.setAttribute("userType", "M");
			session.setAttribute("memberInfo",memberVO);
			mav.setViewName("/main/main");
			
		}else if(sellerVO!=null) {
			session.setAttribute("isLogOn", true);
			session.setAttribute("userType", "S");
			session.setAttribute("memberInfo",sellerVO);
			mav.setViewName("/main/main");
		}else {
			mav.addObject("falseLog", "falseLog");
			mav.setViewName("/member/loginForm");
		}
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/memberDel.do" ,method = RequestMethod.GET)
	public ModelAndView memberDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		MemberVO member= (MemberVO) session.getAttribute("memberInfo");
		String pw= request.getParameter("member_pw");
		String id = member.getMember_id();
		String pw2 = member.getMember_pw();
		if(pw.equals(pw2)) {
		memberService.delMember(id);
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		mav.addObject("alertMember", "success");
		mav.setViewName("/main/main");
		}else {
		mav.addObject("alertMember", "fail");
		mav.setViewName("/main/main");
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("memberVO") MemberVO _memberVO,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
		
		    memberService.addMember(_memberVO);
		    message  = "<script>";
		    message +=" alert('회원가입이 완료되었습니다. 로그인 해주시기 바랍니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('회원가입에 실패하였습니다. 다시 시도해주시기 바랍니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		String result = memberService.overlapped(id);
		resEntity =new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
	
	//異붽�以� 
	@RequestMapping(value="/updateMember.do" , method= RequestMethod.POST)
	public ModelAndView modMember(@ModelAttribute("memberVO") MemberVO _memberVO, HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		memberService.modMember(_memberVO);
		 HttpSession session=request.getSession();
		session.setAttribute("memberInfo",_memberVO);
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("redirect:/member/myPageMain.do"); 
		return mav;
	}
	
	
}
