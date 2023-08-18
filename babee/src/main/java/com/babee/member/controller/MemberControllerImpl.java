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
			session.setAttribute("memberInfo",memberVO);
			mav.setViewName("/main/main");
			
		}else if(sellerVO!=null) {
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo",sellerVO);
			mav.setViewName("/main/main");
		}else {
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
		    message +=" alert('회원 가입 완료되었습니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('회원 가입에 실패하였습니다. 다시 입력해주세요');";
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
	
	//추가중 
	@RequestMapping(value="/updateMember.do" , method= RequestMethod.POST)
	public ModelAndView modMember(HttpServletRequest request, HttpServletResponse response) throws Exception{
						
		String member_id = request.getParameter("member_id");
		String member_pw = request.getParameter("member_pw");
		String member_name = request.getParameter("member_name");		
		String member_email = request.getParameter("member_email");		
		String member_tel1 = request.getParameter("member_tet1");
		String member_tel2 = request.getParameter("member_tet2");
		String member_tel3 = request.getParameter("member_tet3");
		String member_hp1 = request.getParameter("member_hp1");
		String member_hp2 = request.getParameter("member_hp2");
		String member_hp3 = request.getParameter("member_hp3");
		String member_roadAddr = request.getParameter("member_roadAddr");
		String member_jibunAddr = request.getParameter("member_jibunAddr");
		String member_zipcode = request.getParameter("member_zipcode");
		String member_namujiAddr = request.getParameter("member_namujiAddr");
		String member_gender = request.getParameter("member_gender");
		String member_birth = request.getParameter("member_birth");
		String baby_gender = request.getParameter("baby_gender");
		String baby_age = request.getParameter("baby_age");
		
		memberVO.setMember_id(member_id);
		memberVO.setMember_pw(member_pw);
		memberVO.setMember_name(member_name);
		memberVO.setMember_email(member_email);
		memberVO.setMember_tel1(member_tel1);
		memberVO.setMember_tel2(member_tel2);
		memberVO.setMember_tel3(member_tel3);
		memberVO.setMember_hp1(member_hp1);
		memberVO.setMember_hp2(member_hp2);
		memberVO.setMember_hp3(member_hp3);
		memberVO.setMember_id(member_roadAddr);
		memberVO.setMember_id(member_jibunAddr);
		memberVO.setMember_id(member_zipcode);
		memberVO.setMember_id(member_namujiAddr);
		memberVO.setMember_id(member_birth);
		memberVO.setMember_id(member_gender);
		memberVO.setMember_id(baby_gender);
		memberVO.setMember_id(baby_age);
		
		memberService.modMember(memberVO);
		
		
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("redirect:/member/myPageMain.do"); 
		return mav;
	}
	
	
}
