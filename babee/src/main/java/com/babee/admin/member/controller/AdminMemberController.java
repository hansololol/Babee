package com.babee.admin.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.diary.vo.DiaryVO;
import com.babee.seller.vo.SellerVO;

public interface AdminMemberController {
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView memberDetail(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public void modifyMemberInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView deleteMember(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	
	//사업자
	public ModelAndView sellerManageList(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView sellerDetail(@RequestParam("seller_id") String seller_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView sellerManageWait(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView sellerWaitDetail(@RequestParam("seller_id") String seller_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView sellerRegister(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	//public ModelAndView sellerRefuse(HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
 