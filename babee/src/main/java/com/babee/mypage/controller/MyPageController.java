package com.babee.mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.mypage.vo.ReviewVO;
import com.babee.order.vo.RefundVO;

public interface MyPageController {
	public ModelAndView myPageMain(HttpServletRequest request, HttpServletResponse response)  throws Exception ;
	public ModelAndView myOrderDetail(@RequestParam("order_id")  String order_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView cancelMyOrder(@RequestParam("order_id")  String order_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView listMyOrderHistory(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView wishList(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView removeWishList(@RequestParam("articleNO") int articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView refundOrder(@ModelAttribute("refundVO") RefundVO refund, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView myrefund(@RequestParam("order_id") String order_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView reviewWrite(@ModelAttribute("reviewVO") ReviewVO review, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
