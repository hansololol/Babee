package com.babee.order.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.babee.goods.vo.GoodsVO;
import com.babee.order.vo.OrderVO;
/*
 * POST : /v1/payment/ready HTTP/1.1
 * Host : kapi.kakao.com
 * Authorization : KakaoAK 78dfb5e457826bbe2606748a41a4e6e2
 * Content-type : application/x-www-form-urlencoded;charset=utf-8
 * */

@Controller
@RequestMapping(value="/jq")
public class KakaoPayController {
	@Autowired
	private OrderVO orderVO;
	@Autowired
	private GoodsVO goodsVO;
    
	
	@RequestMapping(value="/pay.do")
	public ModelAndView serve(ModelAndView mav, HttpSession s, RedirectView rv) {
		mav.setViewName("/goods/orderResult");
		return mav;
	}
	
	@RequestMapping(value="/kakaopay.do")
	@ResponseBody
	public String kakaopay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		GoodsVO goodsVO = (GoodsVO)session.getAttribute("goods");
		String goods_title = goodsVO.getGoods_title();
		List ordergoods = (List)session.getAttribute("orderInfo");
		OrderVO final_total_price = (OrderVO) ordergoods.get(0);
		int final_total_price1 = final_total_price.getFinal_total_price();
		
		
		try {
			
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection server = (HttpURLConnection) address.openConnection();
			server.setRequestMethod("POST");
			server.setRequestProperty("Authorization", "KakaoAK 78dfb5e457826bbe2606748a41a4e6e2");
			server.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			server.setDoOutput(true);
			String parameter = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id&item_name="+goods_title+"&quantity=1&total_amount="+final_total_price1+"&tax_free_amount=0&approval_url=https://localhost:8080/order/payToOrderGoods.do&cancel_url=https://localhost:8080/cancel&fail_url=https://localhost:8080/fail";
			OutputStream sender = server.getOutputStream();
			DataOutputStream dataout = new DataOutputStream(sender);
			
			dataout.writeBytes(parameter);
			dataout.close();
		
			int resultCode = server.getResponseCode();
		
			InputStream receiver;
			if(resultCode == 200) {
				receiver = server.getInputStream();
			} else {
				receiver = server.getErrorStream();
			}
			InputStreamReader reader = new InputStreamReader(receiver);
			BufferedReader typeReader = new BufferedReader(reader);
			
			return typeReader.readLine();
		
		} catch(MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "{\"result\":\"NO\"}";
	}
	
	
	
 
}