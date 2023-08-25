package com.babee.seller.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.babee.goods.vo.GoodsVO;
import com.babee.seller.vo.SellerVO;

	@Mapper
	@Repository("sellerDAO")
	public interface SellerDAO {
		public SellerVO login(Map loginMap) throws DataAccessException;
		public void insertNewSeller(Map seller) throws DataAccessException;
		public String selectOverlappedID(String id) throws DataAccessException;
		
		public void deleteGoodsImage(int goods_id) throws DataAccessException;
	    public void deleteGoodsImage2(int image_id) throws DataAccessException;
	    public List<GoodsVO> adminGoodsList(@Param("seller_id") String seller_id) throws DataAccessException;
	}
