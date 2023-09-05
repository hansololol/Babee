package com.babee.seller.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.babee.goods.vo.GoodsQNA;
import com.babee.goods.vo.GoodsVO;
import com.babee.seller.vo.SellerVO;

public interface SellerService {
	public SellerVO login(Map loginMap) throws Exception;
	public void addMember(Map sellerVO) throws Exception;
	
	//상품목록
	//public List<GoodsVO> adminGoodsList(String seller_id) throws Exception;
	public List<GoodsVO> adminGoodsList(String seller_id, int startIndex, int itemsPerPage)throws Exception;
	public int getGoodsListCount(String seller_id) throws Exception;
	
	public void removeGoodsImage(int goods_id) throws Exception;

	public void removeGoodsImage2(int goods_image_name1_id) throws Exception;
	
	//업데이트
	public void updateGoods(Map<String, Object> modGoodsMap) throws Exception;

	public void updateGoodsImage(Map<String, Object> modGoodsMap) throws Exception;
	
	//업데이트 전 값불러오기
	public Map<String, Object> getGoodsInfo(int goods_id) throws Exception;
	
	// 오늘 등록된 상품 조회
    public List<GoodsVO> getTodayGoods(String seller_id, int startIndex, int itemsPerPage) throws Exception;
    public int getTodayGoodsCount(String seller_id) throws Exception;
    //1주
    public List<GoodsVO> getOneWeekGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getOneWeekGoodsCount(String seller_id) throws Exception;
    //2주
    public List<GoodsVO> getTwoWeekGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getTwoWeekGoodsCount(String seller_id) throws Exception;
    //1달
    public List<GoodsVO> getOneMonthGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getOneMonthGoodsCount(String seller_id) throws Exception;
    //2달
    public List<GoodsVO> getTwoMonthGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getTwoMonthGoodsCount(String seller_id) throws Exception;
    //3달
    public List<GoodsVO> getThreeMonthGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getThreeMonthGoodsCount(String seller_id) throws Exception;
    //4달
    public List<GoodsVO> getFourMonthGoods(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getFourMonthGoodsCount(String seller_id) throws Exception;
    //정하기
    public List<GoodsVO> getDateGoods(Map<String, Object> getDateGoodsMap)throws Exception;
    public int getDateGoodsCount(Map<String, Object> getDateGoodsMap)throws Exception;
    
    // 사업자가 등록 주문 리스트 조회
    public List<Map<String, Object>> getSellerOrderList(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getSellerOrderListCount(String seller_id) throws Exception;
    //당일
    public List<Map<String, Object>> getSellerOrderListTODAY(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getSellerOrderListTODAYCount(String seller_id) throws Exception;
    //1주일
    public List<Map<String, Object>> getSellerOrderListONEWEEK(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getSellerOrderListONEWEEKCount(String seller_id) throws Exception;
    //2주일
    public List<Map<String, Object>> getSellerOrderListTWOWEEK(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getSellerOrderListTWOWEEKCount(String seller_id) throws Exception;
    //1달
    public List<Map<String, Object>> getSellerOrderListONEMONTH(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getSellerOrderListONEMONTHCount(String seller_id) throws Exception;
    //2달
    public List<Map<String, Object>> getSellerOrderListTWOMONTH(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getSellerOrderListTWOMONTHCount(String seller_id) throws Exception;
    //3달
    public List<Map<String, Object>> getSellerOrderListTHREEMONTH(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getSellerOrderListTHREEMONTHCount(String seller_id) throws Exception;
    //4달
    public List<Map<String, Object>> getSellerOrderListFOURMONTH(@Param("seller_id") String seller_id, @Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws Exception;
    public int getSellerOrderListFOURMONTHCount(String seller_id) throws Exception;
    //정하기
    public List<Map<String, Object>> getSellerOrderListDATE(Map<String, Object> getDateOrderMap) throws Exception;
    	public int getSellerOrderListDATECount(
    	    @Param("seller_id") String seller_id,
    	    @Param("startDate") String startDate,
    	    @Param("endDate") String endDate
    	) throws Exception;
    
    //사업자 배송상태 변경
    public void updateDeliveryStatus(Map<String, Object> deliveryStatusMap) throws Exception;
    
    //사업자 qna리스트
    public List<GoodsQNA> selectAllGoodsQna(Map<String, Object> goodsQnaMap) throws Exception;
    public int selectAllGoodsQnaCount(String seller_id) throws Exception;
    	
    
    //사업자 qna답변
    public void addGoodsQnaAnswer(Map<String, Object> goodsQnaAnswerMap) throws Exception;
    
    public List<Map<String, Object>> sellerOrderInfo(Map<String, Object> sellerOrderInfoMap) throws Exception;
}

