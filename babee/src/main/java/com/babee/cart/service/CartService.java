package com.babee.cart.service;


import java.util.List;
import java.util.Map;

import com.babee.cart.vo.CartVO;

public interface CartService {
	public List<CartVO> myCartList(String memberId) throws Exception;
	//public boolean findCartGoods(CartVO cartVO) throws Exception;
	public boolean findCartGoods(CartVO cartVO) throws Exception;
	public void addGoodsInCart(CartVO cartVO) throws Exception;
	public boolean modifyCartQty(CartVO cartVO) throws Exception;
	public void removeCartGoods(int cart_id) throws Exception;
}

