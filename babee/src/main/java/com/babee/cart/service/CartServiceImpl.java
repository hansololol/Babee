package com.babee.cart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.cart.dao.CartDAO;
import com.babee.cart.vo.CartVO;
import com.babee.goods.vo.GoodsVO;

@Service("cartService")
public class CartServiceImpl  implements CartService{
	
	@Autowired
	private CartDAO cartDAO;
	
	public List<CartVO> myCartList(String memberId) throws Exception{
		
		List<CartVO> resultCartList = cartDAO.selectCartList(memberId);
		
		return resultCartList;
	}
	
	/*public boolean findCartGoods(CartVO cartVO) throws Exception{
		 return cartDAO.selectCountInCart(cartVO);
		
	}*/
	
	public boolean findCartGoods(CartVO cartVO) throws Exception{
		return cartDAO.selectCountInCart(cartVO);
		
	}
	
	public void addGoodsInCart(CartVO cartVO) throws Exception{
		cartDAO.insertGoodsInCart(cartVO);
	}
	
	public boolean modifyCartQty(CartVO cartVO) throws Exception{
		boolean result=true;
		cartDAO.updateCartGoodsQty(cartVO);
		return result;
	}
	public void removeCartGoods(int cart_id) throws Exception{
		cartDAO.deleteCartGoods(cart_id);
	}

	@Override
	public List<GoodsVO> selectGoodsList(int goods_id) throws Exception {
		return cartDAO.selectGoodsList(goods_id);
	}
	
}