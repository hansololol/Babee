package com.babee.order.service;

import java.util.List;

import com.babee.order.vo.OrderVO;

public interface OrderService {
	public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws Exception;
	public void addNewOrder(List<OrderVO> myOrderList) throws Exception;
	public OrderVO findMyOrder(String order_id) throws Exception;
	
	
}
