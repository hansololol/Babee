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
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.babee.goods.vo.GoodsVO;
import com.babee.order.vo.OrderVO;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
/*
 * POST : /v1/payment/ready HTTP/1.1
 * Host : kapi.kakao.com
 * Authorization : KakaoAK 78dfb5e457826bbe2606748a41a4e6e2
 * Content-type : application/x-www-form-urlencoded;charset=utf-8
 * */
import com.google.gson.JsonParser;

@Controller
@RequestMapping(value="/jq")
public class KakaoPayController {
	@Autowired
	private OrderVO orderVO;
	@Autowired
	private GoodsVO goodsVO;
    
	
	@RequestMapping(value="/kakaopay.do")
	@ResponseBody
	public String kakaopay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String successRe = "/goods/orderGoodsForm";
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		GoodsVO goodsVO = (GoodsVO)session.getAttribute("goods");
		String goods_title = goodsVO.getGoods_title();
		 goods_title = URLEncoder.encode(goods_title);
		List ordergoods = (List)session.getAttribute("orderInfo");
		OrderVO orderVO = (OrderVO) ordergoods.get(0);
		String final_total_price = String.valueOf(orderVO.getTotal_goods_price());
		try {
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection server = (HttpURLConnection) address.openConnection();
			server.setRequestMethod("POST");
			server.setRequestProperty("Authorization", "KakaoAK 78dfb5e457826bbe2606748a41a4e6e2");
			server.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			server.setDoOutput(true);
			String parameter = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id&item_name="+goods_title+"&quantity=1&total_amount="+final_total_price+"&tax_free_amount=0&approval_url=http://localhost:8080/jq/kakaoPaySuccess.do&cancel_url=http://localhost:8080/cancel&fail_url=http://localhost:8080/fail";
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
			String jsonObj= typeReader.readLine();
			JsonParser par = new JsonParser();
			JsonObject jsonObject = (JsonObject) par.parse(jsonObj);
			JsonElement tid = jsonObject.get("tid");
			session.setAttribute("tid", tid);
			return jsonObj;
		
		} catch(MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return successRe;
	}

 

	/**
     * 결제 완료 승인
     */
	 @GetMapping("/kakaoPaySuccess.do")
    public ModelAndView ApproveResponse(@RequestParam("pg_token") String pg_token, HttpServletRequest request) {
		 String cid = "TC0ONETIME";
    	HttpSession session=request.getSession();
    	JsonElement tidJson = (JsonElement) session.getAttribute("tid");
    	String tid = tidJson.getAsString();
    
        // 카카오 요청
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.add("cid", cid);
        parameters.add("pg_token", pg_token);
        parameters.add("tid", tid);
        parameters.add("partner_order_id", "partner_order_id");
        parameters.add("partner_user_id", "partner_user_id");
        // 파라미터, 헤더
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());
        
        // 외부에 보낼 url
        RestTemplate restTemplate = new RestTemplate();
        
        OrderVO approveResponse = restTemplate.postForObject(
                "https://kapi.kakao.com/v1/payment/approve",
                requestEntity,
                OrderVO.class);
         ModelAndView mav = new ModelAndView("/goods/orderGoodsForm");
       session.setAttribute("kakaoSuccess", "kakaoSuccess");
        return mav;
    }
 
    /**
     * 카카오 요구 헤더값
     */
    private HttpHeaders getHeaders() {
        HttpHeaders httpHeaders = new HttpHeaders();

        String auth = "KakaoAK " + "78dfb5e457826bbe2606748a41a4e6e2";

        httpHeaders.set("Authorization", auth);
        httpHeaders.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        return httpHeaders;
    }
}