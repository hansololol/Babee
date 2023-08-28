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
		public void deleteGoodsImage2(int goods_image_name1_id) throws DataAccessException;
		
	    public List<GoodsVO> adminGoodsList(@Param("seller_id") String seller_id) throws DataAccessException;
	    
	    
	 // 상품 정보 업데이트
	    void updateGoods(Map<String, Object> modGoodsMap) throws Exception;

	    // 상품 이미지 정보 업데이트
	    void updateGoodsImage(Map<String, Object> modGoodsMap) throws Exception;
		
		//업데이트 전 값 불러오기
		public Map<String, Object> getGoodsInfo(int goods_id) throws DataAccessException;
		
		// 오늘 등록된 상품 조회
	    List<GoodsVO> getTodayGoods() throws DataAccessException;
	}
