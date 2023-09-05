package com.babee.seller.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.babee.goods.vo.GoodsQNA;
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

	//사업자 상품등록
	/*@Override
	public List<GoodsVO> adminGoodsList(String seller_id) throws Exception {
		return sellerDAO.adminGoodsList(seller_id);
	}*/
	@Override
	public List<GoodsVO> adminGoodsList(String seller_id,int startIndex,int itemsPerPage)throws Exception{
		return sellerDAO.adminGoodsList(seller_id, startIndex, itemsPerPage);
	}
	@Override
	public int getGoodsListCount(String seller_id)throws Exception{
		return sellerDAO.getGoodsListCount(seller_id);
	}
	
	//업데이트
	@Override
    public void updateGoods(Map<String, Object> modGoodsMap) throws Exception {
        sellerDAO.updateGoods(modGoodsMap);
    }

    @Override
    public void updateGoodsImage(Map<String, Object> modGoodsMap) throws Exception {
        sellerDAO.updateGoodsImage(modGoodsMap);
    }
	
	//업데이트 전 값 불러오기
	@Override
	public Map<String, Object> getGoodsInfo(int goods_id) throws Exception {
	    return sellerDAO.getGoodsInfo(goods_id);
	}
	
	// 오늘 등록된 상품 조회
	@Override
    public List<GoodsVO> getTodayGoods(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getTodayGoods(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getTodayGoodsCount(String seller_id) {
		return sellerDAO.getTodayGoodsCount(seller_id);
	}
	//1주
	@Override
    public List<GoodsVO> getOneWeekGoods(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getOneWeekGoods(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getOneWeekGoodsCount(String seller_id) {
		return sellerDAO.getOneWeekGoodsCount(seller_id);
	}
	//2주
	@Override
    public List<GoodsVO> getTwoWeekGoods(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getTwoWeekGoods(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getTwoWeekGoodsCount(String seller_id) {
		return sellerDAO.getTwoWeekGoodsCount(seller_id);
	}
	//1달
	@Override
    public List<GoodsVO> getOneMonthGoods(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getOneMonthGoods(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getOneMonthGoodsCount(String seller_id) {
		return sellerDAO.getOneMonthGoodsCount(seller_id);
	}
	//2달
	@Override
    public List<GoodsVO> getTwoMonthGoods(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getTwoMonthGoods(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getTwoMonthGoodsCount(String seller_id) {
		return sellerDAO.getTwoMonthGoodsCount(seller_id);
	}
	//3달
	@Override
    public List<GoodsVO> getThreeMonthGoods(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getThreeMonthGoods(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getThreeMonthGoodsCount(String seller_id) {
		return sellerDAO.getThreeMonthGoodsCount(seller_id);
	}
	//4달
	@Override
    public List<GoodsVO> getFourMonthGoods(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getFourMonthGoods(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getFourMonthGoodsCount(String seller_id) {
		return sellerDAO.getFourMonthGoodsCount(seller_id);
	}
	//정하기
	@Override
    public List<GoodsVO> getDateGoods(Map<String, Object> getDateGoodsMap) {
        return sellerDAO.getDateGoods(getDateGoodsMap);
    }

    @Override
    public int getDateGoodsCount(Map<String, Object> getDateGoodsMap) {
        return sellerDAO.getDateGoodsCount(getDateGoodsMap);
    }
    
    
    
	// 사업자가 등록한 상품 주문 리스트 조회
	@Override
    public List<Map<String, Object>> getSellerOrderList(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getSellerOrderList(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getSellerOrderListCount(String seller_id) {
		return sellerDAO.getSellerOrderListCount(seller_id);
	}
	
	//당일오더
	@Override
    public List<Map<String, Object>> getSellerOrderListTODAY(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getSellerOrderListTODAY(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getSellerOrderListTODAYCount(String seller_id) {
		return sellerDAO.getSellerOrderListTODAYCount(seller_id);
	}
	
	//1주
	@Override
    public List<Map<String, Object>> getSellerOrderListONEWEEK(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getSellerOrderListONEWEEK(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getSellerOrderListONEWEEKCount(String seller_id) {
		return sellerDAO.getSellerOrderListONEWEEKCount(seller_id);
	}
	//2주
	@Override
    public List<Map<String, Object>> getSellerOrderListTWOWEEK(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getSellerOrderListTWOWEEK(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getSellerOrderListTWOWEEKCount(String seller_id) {
		return sellerDAO.getSellerOrderListTWOWEEKCount(seller_id);
	}
	//1달
	@Override
    public List<Map<String, Object>> getSellerOrderListONEMONTH(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getSellerOrderListONEMONTH(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getSellerOrderListONEMONTHCount(String seller_id) {
		return sellerDAO.getSellerOrderListONEMONTHCount(seller_id);
	}
	//2달
	@Override
    public List<Map<String, Object>> getSellerOrderListTWOMONTH(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getSellerOrderListTWOMONTH(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getSellerOrderListTWOMONTHCount(String seller_id) {
		return sellerDAO.getSellerOrderListTWOMONTHCount(seller_id);
	}
	//3달
	@Override
    public List<Map<String, Object>> getSellerOrderListTHREEMONTH(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getSellerOrderListTHREEMONTH(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getSellerOrderListTHREEMONTHCount(String seller_id) {
		return sellerDAO.getSellerOrderListTHREEMONTHCount(seller_id);
	}
	//4달
	@Override
    public List<Map<String, Object>> getSellerOrderListFOURMONTH(String seller_id, int startIndex, int itemsPerPage) {
        return sellerDAO.getSellerOrderListFOURMONTH(seller_id, startIndex, itemsPerPage);
    }
	@Override
	public int getSellerOrderListFOURMONTHCount(String seller_id) {
		return sellerDAO.getSellerOrderListFOURMONTHCount(seller_id);
	}
	//정하기
	@Override
	public List<Map<String, Object>> getSellerOrderListDATE(Map<String, Object> getDateOrderMap) throws Exception{
        return sellerDAO.getSellerOrderListDATE(getDateOrderMap);
    }

    @Override
    public int getSellerOrderListDATECount(
        String seller_id,
        String startDate,
        String endDate) {
        return sellerDAO.getSellerOrderListDATECount(seller_id, startDate, endDate);
    }
	
	

	//사업자 배송상태 변경
	@Override
	public void updateDeliveryStatus(Map<String, Object> deliveryStatusMap) throws Exception {
	    sellerDAO.updateDeliveryStatus(deliveryStatusMap);
	}
	
	//사업자 상품qna리스트
	@Override
    public List<GoodsQNA> selectAllGoodsQna(Map<String, Object> goodsQnaMap) {
        return sellerDAO.selectAllGoodsQna(goodsQnaMap);
    }
	@Override
	public int selectAllGoodsQnaCount(String seller_id) throws Exception{
		return sellerDAO.selectAllGoodsQnaCount(seller_id);
	}
	
	//사업자 qna답변
	@Override
    public void addGoodsQnaAnswer(Map<String, Object> goodsQnaAnswerMap) throws Exception {
        sellerDAO.GoodsQnaAnswer(goodsQnaAnswerMap);
    }

	
	@Override
    public List<Map<String, Object>> sellerOrderInfo(Map<String, Object> sellerOrderInfoMap) throws Exception {
        return sellerDAO.sellerOrderInfo(sellerOrderInfoMap);
    }

	//사업자 정보 수정
	@Override
	public void modSeller(SellerVO sellerVO) throws Exception {
		sellerDAO.modSeller(sellerVO);
	}

}
