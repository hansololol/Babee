package com.babee.seller.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.babee.goods.vo.GoodsVO;
import com.babee.seller.dao.SellerDAO;
import com.babee.seller.vo.SellerVO;

@Service("sellerService")
public class SellerServiceImpl implements SellerService{
	@Autowired
	private SellerDAO sellerDAO;
	
	@Override
	public SellerVO login(Map loginMap) throws Exception {
	
		return sellerDAO.login(loginMap);
	}

	@Override
	public void addMember(Map seller) throws Exception {
		// TODO Auto-generated method stub
		sellerDAO.insertNewSeller(seller);
	}
	
	@Override
	public void removeGoodsImage(int goods_id) throws Exception {
		System.out.println("상품 삭제 시 goods_id 확인 : " + goods_id);
		sellerDAO.deleteGoodsImage(goods_id);
	}

	@Override
	public void removeGoodsImage2(int goods_image_name1_id) throws Exception {
		System.out.println("상품 삭제 시 image_id 확인: " + goods_image_name1_id);
		sellerDAO.deleteGoodsImage2(goods_image_name1_id);
	}

	@Override
	public List<GoodsVO> adminGoodsList(String seller_id) throws Exception {
		return sellerDAO.adminGoodsList(seller_id);
	}
	
	
}
