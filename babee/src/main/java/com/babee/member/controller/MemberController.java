package com.babee.member.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.babee.member.vo.MemberVO;

public interface MemberController {
	public ModelAndView login(@RequestParam Map<String, String> loginMap,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity  addMember(@ModelAttribute("member") MemberVO member,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity   overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView memberDel(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//회원수정 추가
	public ModelAndView modMember(@ModelAttribute("member") MemberVO member,HttpServletRequest request, HttpServletResponse response) throws Exception;
}	