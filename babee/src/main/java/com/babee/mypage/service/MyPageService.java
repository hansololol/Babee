package com.babee.mypage.service;

import java.util.List;
import java.util.Map;

import com.babee.cart.vo.CartVO;
import com.babee.goods.vo.GoodsVO;
import com.babee.mypage.vo.ReviewVO;
import com.babee.mypage.vo.WishVO;
import com.babee.order.vo.OrderVO;
import com.babee.order.vo.RefundVO;

public interface MyPageService{
	public List<OrderVO> listMyOrderGoods(String member_id) throws Exception;
	
	public List findMyOrderInfo(String order_id) throws Exception;
	
	public List<OrderVO> listMyOrderHistory(Map dateMap) throws Exception;
	
	public void cancelOrder(String order_id) throws Exception;

	public void refundOrder(RefundVO refundOrder) throws Exception;
	
	public boolean findWishList(WishVO wishVO) throws Exception;	//위시리스트 값 여부 확인
	
	public void addWishList(WishVO wishVO) throws Exception;	//위시리스트 추가
	
	public List<WishVO> selectWishList(String member_id) throws Exception;
	public List<GoodsVO> selectWishGoodsList(int goods_id) throws Exception;
	public List<ReviewVO> selectReview(String member_id) throws Exception;
	public void removeWishList(int articleNO) throws Exception;
	public void addReview(Map reviewMap) throws Exception;
	
}
