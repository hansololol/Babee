package com.babee.seller.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.goods.vo.GoodsVO;

public interface SellerController {
	public ModelAndView login(@RequestParam Map<String, String> loginMap,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity  addSeller(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public void removeGoodsImage(@RequestParam("goods_id") int goods_id, // @RequestParam("image_id") int image_id,
			@RequestParam("goods_image_name1_id") int goods_image_name1_id,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception;
	//업데이트
	public ModelAndView modGoods(@RequestParam("goods_id") int goods_id, @RequestParam Map<String, Object> modGoodsMap,
            MultipartHttpServletRequest multipartRequest,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception;
	//업데이트 전 값불러오기
		public ModelAndView getGoodsInfo	(@RequestParam("goods_id") int goodsId,
	            HttpServletRequest request,
	            HttpServletResponse response) throws Exception;
		
		//당일 등록상품 조회
		//public ModelAndView getTodayGoods(HttpServletRequest request, HttpServletResponse response) throws Exception;
		
		// 사업자가 등록한 상품 주문 리스트 조회
	    public ModelAndView getSellerOrderList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	    
	    // 주문 상태 변경
	    public ModelAndView updateDeliveryStatus(@RequestParam("order_id") int order_id,
	                                             @RequestParam("delivery_status") String delivery_status,
	                                             HttpServletRequest request,
	                                             HttpServletResponse response) throws Exception;
	    
	    //사업자 상품qna 리스트
	    public ModelAndView selectAllGoodsQna(HttpServletRequest request, HttpServletResponse response) throws Exception;

}
