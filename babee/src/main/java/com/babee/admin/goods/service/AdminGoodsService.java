package com.babee.admin.goods.service;

import java.util.List;
import java.util.Map;

import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;
import com.babee.order.vo.OrderVO;

public interface AdminGoodsService {
   public int  addNewGoods(Map newGoodsMap) throws Exception;
   public List<GoodsVO> listNewGoods(Map condMap) throws Exception;
   public Map goodsDetail(int goods_id) throws Exception;
   public List goodsImageFile(int goods_id) throws Exception;
   public void modifyGoodsInfo(Map goodsMap) throws Exception;
   public void modifyGoodsImage(List<ImageFileVO> imageFileList) throws Exception;
   public List<OrderVO> listOrderGoods(Map condMap) throws Exception;
   public void modifyOrderGoods(Map orderMap) throws Exception;
   //public void removeGoodsImage(int image_id) throws Exception;
   public void addNewGoodsImage(Map newGoodsMap) throws Exception;
   
    //관리자상품조회
 	public List<GoodsVO> allGoodsList() throws Exception;
 	
 	//관리자 상품삭제
 	public void removeGoodsImage1(int goods_id) throws Exception;
 	public void removeGoodsImage2(int goods_image_name1_id) throws Exception;
}