package com.babee.seller.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.babee.goods.vo.GoodsQNA;
import com.babee.goods.vo.GoodsVO;
import com.babee.seller.vo.SellerVO;

public interface SellerService {
	public SellerVO login(Map loginMap) throws Exception;
	public void addMember(Map sellerVO) throws Exception;

	public List<GoodsVO> adminGoodsList(String seller_id) throws Exception;

	public void removeGoodsImage(int goods_id) throws Exception;

	public void removeGoodsImage2(int goods_image_name1_id) throws Exception;
	
	//업데이트
	public void updateGoods(Map<String, Object> modGoodsMap) throws Exception;

	public void updateGoodsImage(Map<String, Object> modGoodsMap) throws Exception;
	
	//업데이트 전 값불러오기
	public Map<String, Object> getGoodsInfo(int goods_id) throws Exception;
	
	// 오늘 등록된 상품 조회
    public List<GoodsVO> getTodayGoods(String seller_id) throws DataAccessException;
    
    // 사업자가 등록한 상품 주문 리스트 조회
    public List<Map<String, Object>> getSellerOrderList(String seller_id) throws DataAccessException;
    
    //사업자 배송상태 변경
    public void updateDeliveryStatus(Map<String, Object> deliveryStatusMap) throws Exception;
    
    //사업자 qna리스트
    public List<GoodsQNA> selectAllGoodsQna(Map<String, Object> goodsQnaMap) throws DataAccessException;
    	
    
    //사업자 qna답변
    public void addGoodsQnaAnswer(Map<String, Object> goodsQnaAnswerMap) throws Exception;
}

