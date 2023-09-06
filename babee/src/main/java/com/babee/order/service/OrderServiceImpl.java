package com.babee.order.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.order.dao.OrderDAO;
import com.babee.order.vo.OrderVO;


@Service("orderService")
@Transactional(propagation=Propagation.REQUIRED)
public class OrderServiceImpl implements OrderService {
   @Autowired
   private OrderDAO orderDAO;
   
   public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws Exception{
      List<OrderVO> orderGoodsList;
      orderGoodsList=orderDAO.listMyOrderGoods(orderVO);
      return orderGoodsList;
   }
   
   public void addNewOrder(List<OrderVO> myOrderList) throws Exception{
      orderDAO.insertNewOrder(myOrderList);
   }
   
   public OrderVO findMyOrder(String order_id) throws Exception{
      return orderDAO.findMyOrder(order_id);
   }

   @Override
   public void stock(int goods_id, int order_goods_qty) {
      System.out.println("order 서비스: " + order_goods_qty);
      orderDAO.stock(goods_id, order_goods_qty);
      
   }
   
   @Override
   @Transactional
    public void updateBuycntByGoodsId(Map<String, Object> updateMap) throws Exception {
        // OrderDAO의 stock 메서드를 호출하여 buycnt를 업데이트
        orderDAO.updateBuycntByGoodsId(updateMap);
    }

}