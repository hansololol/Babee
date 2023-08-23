package com.babee.goods.service;

import java.lang.reflect.Member;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.text.html.ImageView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.goods.dao.GoodsDAO;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	
	@Override
    public List<GoodsVO> getAllGoods() {
        return goodsDAO.selectAllGoods();  
    }
	
	
	public List<GoodsVO> getAllCategoryGoods(Map goods) {
		
		return goodsDAO.selectAllCategoryGoods(goods);  
	}
	
	
	public Map goodsDetail(String _goods_id) throws Exception {
		Map goodsMap=new HashMap();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		//List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
		//goodsMap.put("imageList", imageList);
		return goodsMap;
	}
	
	
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		return list;
	}
	
	
	public ImageFileVO goodsDetailImage(String member_id) throws Exception {
		ImageFileVO image= goodsDAO.selectGoodsDetailImage(member_id);
		return image;
	}
	
	
	public List<GoodsVO> searchGoods(String searchWord) throws Exception{
		List goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}

	
	
	public List<GoodsVO> hotGoodsList()throws Exception{
		return goodsDAO.hotGoodsList();
		
	}
	
}
