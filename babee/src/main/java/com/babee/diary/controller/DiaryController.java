package com.babee.diary.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


public interface DiaryController {
	
	public ModelAndView diaryList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity addDiary(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception;
	
}
