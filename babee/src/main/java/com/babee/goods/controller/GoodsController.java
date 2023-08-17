package com.babee.goods.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
	
public interface GoodsController  {
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,HttpServletRequest request, HttpServletResponse response) throws Exception;
}
