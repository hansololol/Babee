package com.babee.seller.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
