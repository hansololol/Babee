package com.babee.community.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.community.vo.FreeboardVO;
import com.babee.community.vo.InfoVO;


public interface CommunityController {
	public ModelAndView freeboardList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView addFreeboard(@ModelAttribute("freeboardVO") FreeboardVO freeboard, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView freeboardDetail(@RequestParam("articleNO") String articleNO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modfreeboardForm(@RequestParam("articleNO") String articleNO, HttpServletRequest request, HttpServletResponse response)throws Exception;
	public ModelAndView modFreeboard(@ModelAttribute("freeboardVO") FreeboardVO freeboard, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView addComment(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView removeFreeboard(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView addqna(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView myqnaList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	
	public ModelAndView addInfo(@ModelAttribute("infoVO") InfoVO info, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView infoboardList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView admininfoDetail(@RequestParam("articleNO") String articleNO, HttpServletRequest request, HttpServletResponse response)throws Exception;
	
	
	public ModelAndView infoList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView removeInfo(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modinfoForm(@RequestParam("articleNO") String articleNO, HttpServletRequest request , HttpServletResponse response) throws Exception ;
	public ModelAndView modInfo(InfoVO info, MultipartHttpServletRequest multipartRequest, HttpServletRequest request,	HttpServletResponse response) throws Exception;

			

}
