package com.babee.goods.service;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;

import com.babee.goods.vo.CategoryVO;
import com.babee.goods.vo.GoodsQNA;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;


public interface GoodsService {
	
	
	public Map goodsDetail(String _goods_id) throws Exception;
	public List<GoodsVO> getAllCategoryGoods(Map goods) throws Exception;
	public List<String> keywordSearch(String keyword) throws Exception;
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;
	//상품조회
	public List<GoodsVO> getAllGoods(int startIndex, int itemsPerPage) throws Exception;
	public int selectAllGoodsCount() throws Exception;
	//
	public ImageFileVO goodsDetailImage(String member_id) throws Exception;
	public void deleteGoodsQNA(GoodsQNA goodsQNA) throws Exception;
	public void insertGoodsQNA(GoodsQNA goodsQNA) throws Exception;
	public List<GoodsQNA> getAllGoodsQna(String goods_id)throws Exception;
	
	public List<GoodsVO> seasonGoodsList()throws Exception;
	public List getAllcg(CategoryVO category) throws Exception;
	public List getfitList(String baby_age) throws Exception;
	public Map getsubcg(String sub_category) throws Exception;
	//상품 옵션조회
	public List<GoodsVO> selectSort(String sort,int startIndex, int itemsPerPage) throws Exception;
	public int selectSortCount() throws Exception;
	public List<GoodsVO> hotGoodsList(int startIndex, int itemsPerPage) throws Exception;
	public int hotGoodsListCount() throws Exception;
	//
	public List<GoodsVO> hotGoodsListMain() throws Exception;
	
	public void reviewStatus(String goods_id);
}
