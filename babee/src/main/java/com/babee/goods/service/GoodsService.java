package com.babee.goods.service;


import java.util.List;
import java.util.Map;

import com.babee.goods.vo.CategoryVO;
import com.babee.goods.vo.GoodsQNA;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;


public interface GoodsService {
	
	
	public Map goodsDetail(String _goods_id) throws Exception;
	public List<GoodsVO> getAllCategoryGoods(Map goods) throws Exception;
	public List<String> keywordSearch(String keyword) throws Exception;
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;
	public List<GoodsVO> getAllGoods() throws Exception;
	public ImageFileVO goodsDetailImage(String member_id) throws Exception;
	public void deleteGoodsQNA(GoodsQNA goodsQNA) throws Exception;
	public void insertGoodsQNA(GoodsQNA goodsQNA) throws Exception;
	public List<GoodsQNA> getAllGoodsQna(String goods_id)throws Exception;
	public List<GoodsVO> hotGoodsList()throws Exception;
	public List<GoodsVO> seasonGoodsList()throws Exception;
	public List getAllcg(CategoryVO category) throws Exception;
}
