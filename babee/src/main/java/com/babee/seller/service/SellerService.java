package com.babee.seller.service;

import java.util.List;
import java.util.Map;

import com.babee.goods.vo.GoodsVO;
import com.babee.seller.vo.SellerVO;

public interface SellerService {
	public SellerVO login(Map loginMap) throws Exception;
	public void addMember(Map sellerVO) throws Exception;

	public List<GoodsVO> adminGoodsList(String seller_id) throws Exception;

	public void removeGoodsImage(int goods_id) throws Exception;

	public void removeGoodsImage2(int image_id) throws Exception;
}
