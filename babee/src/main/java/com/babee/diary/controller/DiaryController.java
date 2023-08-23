package com.babee.diary.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.diary.vo.DiaryVO;


public interface DiaryController {
	public ModelAndView diaryList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView addDiary(@ModelAttribute("diaryVO") DiaryVO diary, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView diaryDetail(@RequestParam("dir_no") String dir_no,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modDiary(@ModelAttribute("diaryVO") DiaryVO diary, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
