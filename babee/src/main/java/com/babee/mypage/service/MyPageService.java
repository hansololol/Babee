package com.babee.mypage.service;

import java.util.List;
import java.util.Map;

import com.babee.order.vo.OrderVO;
import com.babee.order.vo.RefundVO;

public interface MyPageService{
	public List<OrderVO> listMyOrderGoods(String member_id) throws Exception;
	public List findMyOrderInfo(String order_id) throws Exception;
	public List<OrderVO> listMyOrderHistory(Map dateMap) throws Exception;
	
	public void cancelOrder(String order_id) throws Exception;

	public MemberVO myDetailInfo(String member_id) throws Exception;

	public void refundOrder(RefundVO refundOrder) throws Exception;


}
