package com.babee.mypage.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.goods.vo.GoodsVO;
import com.babee.mypage.dao.MyPageDAO;
import com.babee.mypage.vo.ReviewVO;
import com.babee.mypage.vo.WishVO;
import com.babee.order.vo.OrderVO;
import com.babee.order.vo.RefundVO;

@Service("myPageService")
@Transactional(propagation=Propagation.REQUIRED)
public class MyPageServiceImpl  implements MyPageService{
	
	@Autowired
	private MyPageDAO myPageDAO;

	public List<OrderVO> listMyOrderGoods(String member_id) throws Exception{
		return myPageDAO.selectMyOrderGoodsList(member_id);
	}
	
	public List findMyOrderInfo(String order_id) throws Exception{
		return myPageDAO.selectMyOrderInfo(order_id);
	}
	
	public List<OrderVO> listMyOrderHistory(Map dateMap) throws Exception{
		return myPageDAO.selectMyOrderHistoryList(dateMap);
	}
	
	public void cancelOrder(String order_id) throws Exception{
		myPageDAO.updateMyOrderCancel(order_id);
	}
	public void refundOrder(RefundVO refundOrder) throws Exception{
		myPageDAO.updateMyOrderRefund(refundOrder);
	}
	
	public boolean findWishList(WishVO wishVO) throws Exception{
		return myPageDAO.selectCountWishList(wishVO);
	}
	
	public void addWishList(WishVO wishVO) throws Exception{
		myPageDAO.insertWishList(wishVO);
	}
	
	public List<WishVO> selectWishList(String member_id) throws Exception{
		
		List<WishVO> resultWishList = myPageDAO.selectWishList(member_id);
		
		return resultWishList;
	}
	
	@Override
	public List<GoodsVO> selectWishGoodsList(int goods_id) throws Exception {
		return myPageDAO.selectWishGoodsList(goods_id);
	}
	
	public void removeWishList(int articleNO) throws Exception{
		myPageDAO.deleteWishList(articleNO);
	}
	
	@Override
	public void addReview(Map reviewMap) throws Exception {
		myPageDAO.insertNewReview(reviewMap);
		myPageDAO.insertImage(reviewMap);
	}
	@Override
	public void delReview(Map delMap) throws Exception {
		myPageDAO.deleteReview(delMap);
	}
	
	@Override
	public List<ReviewVO> selectReview(String member_id) throws Exception{
		return myPageDAO.selectReviewList(member_id);
	}
	@Override
	public List<ReviewVO> selectGoodsReview(String goods_id) throws Exception{
		return myPageDAO.selectGoodsReviewList(goods_id);
	}
}
