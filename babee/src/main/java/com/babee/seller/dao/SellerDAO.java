package com.babee.seller.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import com.babee.goods.vo.GoodsQNA;
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
		
		
		//상품등록리스트
	    //public List<GoodsVO> adminGoodsList(@Param("seller_id") String seller_id) throws DataAccessException;
		public List<GoodsVO> adminGoodsList(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
		public int getGoodsListCount(@Param("seller_id") String seller_id) throws DataAccessException;
	    
	 // 상품 정보 업데이트
	    public void updateGoods(Map<String, Object> modGoodsMap) throws Exception;

	    // 상품 이미지 정보 업데이트
	    public void updateGoodsImage(Map<String, Object> modGoodsMap) throws Exception;
		
		//업데이트 전 값 불러오기
		public Map<String, Object> getGoodsInfo(int goods_id) throws DataAccessException;
		
		// 오늘 등록된 상품 조회
	    public List<GoodsVO> getTodayGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getTodayGoodsCount(String seller_id) throws DataAccessException;
	    //1주
	    public List<GoodsVO> getOneWeekGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getOneWeekGoodsCount(String seller_id) throws DataAccessException;
	    //2주
	    public List<GoodsVO> getTwoWeekGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getTwoWeekGoodsCount(String seller_id) throws DataAccessException;
	    //1달
	    public List<GoodsVO> getOneMonthGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getOneMonthGoodsCount(String seller_id) throws DataAccessException;
	    //2달
	    public List<GoodsVO> getTwoMonthGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getTwoMonthGoodsCount(String seller_id) throws DataAccessException;
	    //3달
	    public List<GoodsVO> getThreeMonthGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getThreeMonthGoodsCount(String seller_id) throws DataAccessException;
	    //4달
	    public List<GoodsVO> getFourMonthGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getFourMonthGoodsCount(String seller_id) throws DataAccessException;
	    //정하기
	    public List<GoodsVO> getDateGoods(Map<String, Object> getDateGoodsMap)throws DataAccessException;
	    public int getDateGoodsCount(Map<String, Object> getDateGoodsMap)throws DataAccessException;
	    
	    // 사업자가 등록한 상품 주문 리스트 조회
	    public List<Map<String, Object>> getSellerOrderList(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getSellerOrderListCount(String seller_id) throws DataAccessException;
	    //당일주문
	    public List<Map<String, Object>> getSellerOrderListTODAY(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getSellerOrderListTODAYCount(String seller_id) throws DataAccessException;
	    //1주일
	    public List<Map<String, Object>> getSellerOrderListONEWEEK(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getSellerOrderListONEWEEKCount(String seller_id) throws DataAccessException;
	    //2주일
	    public List<Map<String, Object>> getSellerOrderListTWOWEEK(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getSellerOrderListTWOWEEKCount(String seller_id) throws DataAccessException;
	    //1달
	    public List<Map<String, Object>> getSellerOrderListONEMONTH(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getSellerOrderListONEMONTHCount(String seller_id) throws DataAccessException;
	    //2달
	    public List<Map<String, Object>> getSellerOrderListTWOMONTH(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getSellerOrderListTWOMONTHCount(String seller_id) throws DataAccessException;
	    //3달
	    public List<Map<String, Object>> getSellerOrderListTHREEMONTH(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getSellerOrderListTHREEMONTHCount(String seller_id) throws DataAccessException;
	    //4달
	    public List<Map<String, Object>> getSellerOrderListFOURMONTH(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	    public int getSellerOrderListFOURMONTHCount(String seller_id) throws DataAccessException;
	    //정하기
	    public List<Map<String, Object>> getSellerOrderListDATE(Map<String, Object> getDateOrderMap) throws Exception;
	    	public int getSellerOrderListDATECount(
	    	    @Param("seller_id") String seller_id,
	    	    @Param("startDate") String startDate,
	    	    @Param("endDate") String endDate
	    	) throws DataAccessException;
	    
	    //사업자 배송상태 업데이트
	    public void updateDeliveryStatus(Map<String, Object> deliveryStatusMap) throws DataAccessException;
	    
	    //사업자 qna문의내역 리스트
	    public List<GoodsQNA> selectAllGoodsQna(Map<String, Object> goodsQnaMap) throws DataAccessException;
	    public int selectAllGoodsQnaCount(String seller_id) throws DataAccessException;
	    
	    //사업자 qna문의내역 답변
	    public void GoodsQnaAnswer(Map<String, Object> goodsQnaAnswerMap) throws DataAccessException;
	    
	  //사업자 정보 수정
	    public void modSeller(SellerVO sellerVO) throws DataAccessException;
	    
	    

	}
