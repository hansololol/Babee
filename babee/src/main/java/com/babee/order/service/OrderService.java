package com.babee.order.service;

import java.util.List;
import java.util.Map;

import com.babee.order.vo.OrderVO;

public interface OrderService {
   public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws Exception;
   public void addNewOrder(List<OrderVO> myOrderList) throws Exception;
   public OrderVO findMyOrder(String order_id) throws Exception;
   
   public void stock(int goods_id, int order_goods_qty);
   
   public void updateBuycntByGoodsId(Map<String, Object> updateMap) throws Exception;
}