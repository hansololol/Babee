package com.babee.admin.goods.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.admin.goods.dao.AdminGoodsDAO;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;
import com.babee.order.vo.OrderVO;


@Service("adminGoodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminGoodsServiceImpl implements AdminGoodsService {
   @Autowired
   private AdminGoodsDAO adminGoodsDAO;
   
   
   @Override
   public int addNewGoods(Map newGoodsMap) throws Exception{
      int goods_id = adminGoodsDAO.insertNewGoods(newGoodsMap);
      
      ArrayList<ImageFileVO> imageFileList = (ArrayList)newGoodsMap.get("imageFileList");
      for(ImageFileVO imageFileVO : imageFileList) {
         //imageFileVO.setGoods_id(goods_id);
         
         System.out.println("굿굿"+goods_id);//이게문제야시빨ㅃ리ㅏㅣ라집ㄼ지라ㅣ아이
         System.out.println("뭐야"+newGoodsMap);
         System.out.println("얘는뭘까?"+newGoodsMap.get("goods_id"));
      }
      adminGoodsDAO.insertGoodsImageFile(newGoodsMap);
      return goods_id;
   }
   
   @Override
   public List<GoodsVO> listNewGoods(Map condMap) throws Exception{
      return adminGoodsDAO.selectNewGoodsList(condMap);
   }
   @Override
   public Map goodsDetail(int goods_id) throws Exception {
      Map goodsMap = new HashMap();
      GoodsVO goodsVO=adminGoodsDAO.selectGoodsDetail(goods_id);
      List imageFileList =adminGoodsDAO.selectGoodsImageFileList(goods_id);
      goodsMap.put("goods", goodsVO);
      goodsMap.put("imageFileList", imageFileList);
      return goodsMap;
   }
   @Override
   public List goodsImageFile(int goods_id) throws Exception{
      List imageList =adminGoodsDAO.selectGoodsImageFileList(goods_id);
      return imageList;
   }
   
   @Override
   public void modifyGoodsInfo(Map goodsMap) throws Exception{
      adminGoodsDAO.updateGoodsInfo(goodsMap);
      
   }   
   @Override
   public void modifyGoodsImage(List<ImageFileVO> imageFileList) throws Exception{
      adminGoodsDAO.updateGoodsImage(imageFileList); 
   }
   
   @Override
   public List<OrderVO> listOrderGoods(Map condMap) throws Exception{
      return adminGoodsDAO.selectOrderGoodsList(condMap);
   }
   @Override
   public void modifyOrderGoods(Map orderMap) throws Exception{
      adminGoodsDAO.updateOrderGoods(orderMap);
   }
   
   /*@Override
   public void removeGoodsImage(int image_id) throws Exception{
      adminGoodsDAO.deleteGoodsImage(image_id);
   }*/
   
   @Override
   public void addNewGoodsImage(Map newGoodsMap) throws Exception{
      adminGoodsDAO.insertGoodsImageFile(newGoodsMap);
   }
   
 //관리자 상품조회
 	@Override
 	   public List<GoodsVO> allGoodsList() throws Exception {
 	       return adminGoodsDAO.allGoodsList();
 	   }
 	
 	//관리자 상품삭제
 	@Override
 	public void removeGoodsImage1(int goods_id) throws Exception {
 		System.out.println("상품 삭제 시 goods_id 확인 : " + goods_id);
 		adminGoodsDAO.adminGoodsDelete1(goods_id);
 	}

 	@Override
 	public void removeGoodsImage2(int goods_image_name1_id) throws Exception {
 		System.out.println("상품 삭제 시 image_id 확인: " + goods_image_name1_id);
 		adminGoodsDAO.adminGoodsDelete2(goods_image_name1_id);
 	}
   
}