package com.babee.community.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.community.vo.CommentVO;
import com.babee.community.vo.FreeboardVO;


public interface CommunityController {
	public ModelAndView freeboardList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView addFreeboard(@ModelAttribute("freeboardVO") FreeboardVO freeboard, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView freeboardDetail(@RequestParam("articleNO") String articleNO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	//public ModelAndView modDiary(@ModelAttribute("diaryVO") DiaryVO diary, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//댓글 작성중
	public ModelAndView addComment(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
