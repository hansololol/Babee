package com.babee.seller.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;


import com.babee.seller.vo.SellerVO;

	@Mapper
	@Repository("sellerDAO")
	public interface SellerDAO {
		public SellerVO login(Map loginMap) throws DataAccessException;
		public void insertNewSeller(Map seller) throws DataAccessException;
		public String selectOverlappedID(String id) throws DataAccessException;
	}
