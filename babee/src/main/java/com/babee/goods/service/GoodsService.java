package com.babee.goods.service;


import java.util.List;
import java.util.Map;

import com.babee.goods.vo.CategoryVO;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;


public interface GoodsService {
	
	
	public Map goodsDetail(String _goods_id) throws Exception;
	public List<GoodsVO> getAllCategoryGoods(Map goods) throws Exception;
	public List<String> keywordSearch(String keyword) throws Exception;
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;
	public List<GoodsVO> getAllGoods() throws Exception;
	public ImageFileVO goodsDetailImage(String member_id) throws Exception;
	
	public List<CategoryVO> getAllcg() throws Exception;
}
