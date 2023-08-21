package com.babee.cart.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.babee.cart.vo.CartVO;
import com.babee.goods.vo.GoodsVO;

public interface CartController {
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response) throws Exception;

	// 장바구니
	//public ModelAndView addGoodsInCart(@ModelAttribute("cartVO") CartVO cartVO, HttpServletRequest request,HttpServletResponse response) throws Exception;

	
	public @ResponseBody String modifyCartQty(@RequestParam("goods_id") int goods_id,
			@RequestParam("cart_goods_qty") String cart_goods_qty, HttpServletRequest request,
			HttpServletResponse response) throws Exception;

	public ModelAndView removeCartGoods(@RequestParam("cart_id") int cart_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception;

}
