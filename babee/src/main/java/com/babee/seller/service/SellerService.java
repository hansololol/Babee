package com.babee.seller.service;

import java.util.Map;

import com.babee.seller.vo.SellerVO;

public interface SellerService {
	public SellerVO login(Map loginMap) throws Exception;
	public void addMember(Map sellerVO) throws Exception;
	
}
