package com.babee.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.mypage.vo.ReviewVO;
import com.babee.order.vo.RefundVO;

public interface MyPageController {
	public ModelAndView myPageMain(HttpServletRequest request, HttpServletResponse response)  throws Exception ;
	
	//주문
	public ModelAndView myOrderDetail(@RequestParam("order_id")  String order_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView cancelMyOrder(@RequestParam("order_id")  String order_id,@RequestParam("orderNO")  int orderNO,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView listMyOrderHistory(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	//위시리스트
	public ModelAndView wishList(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView removeWishList(@RequestParam("articleNO") int articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//환불
	public ModelAndView refundOrder(@ModelAttribute("refundVO") RefundVO refund,@RequestParam("order_id") String order_id, @RequestParam("returnPrice") int returnPrice,HttpServletRequest request,
			HttpServletResponse response) throws Exception;
	public ModelAndView myrefund(@RequestParam("order_id") String order_id,@RequestParam("orderNO") int orderNO, HttpServletRequest request,
			HttpServletResponse response) throws Exception;
	
	//리뷰
	public ModelAndView reviewWrite(@ModelAttribute("reviewVO") ReviewVO review, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView myReviewList(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView removeGoodsReview(HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
