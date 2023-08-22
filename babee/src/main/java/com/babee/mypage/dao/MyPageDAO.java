package com.babee.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.babee.cart.vo.CartVO;
import com.babee.goods.vo.GoodsVO;
import com.babee.member.vo.MemberVO;
import com.babee.mypage.vo.WishVO;
import com.babee.order.vo.OrderVO;
import com.babee.order.vo.RefundVO;

@Mapper
@Repository("myPageDAO")
public interface MyPageDAO {
	public List<OrderVO> selectMyOrderGoodsList(String member_id) throws DataAccessException;
	public List<OrderVO> selectMyOrderInfo(String order_id) throws DataAccessException;
	public List<OrderVO> selectMyOrderHistoryList(Map dateMap) throws DataAccessException;
	public void updateMyInfo(Map memberMap) throws DataAccessException;
	public MemberVO selectMyDetailInfo(String member_id) throws DataAccessException;
	public void updateMyOrderCancel(String order_id) throws DataAccessException;
	public void updateMyOrderRefund(RefundVO orderVO) throws DataAccessException;
	public boolean selectCountWishList(WishVO wishVO) throws DataAccessException;
	public void insertWishList(WishVO wishVO) throws DataAccessException;
	public List<WishVO> selectWishList(String memberId) throws DataAccessException;
	public List<GoodsVO> selectWishGoodsList(int goods_id) throws DataAccessException;
	public void deleteWishList(int articleNO) throws DataAccessException;
}
