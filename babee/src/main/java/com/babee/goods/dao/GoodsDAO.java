package com.babee.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.babee.goods.vo.CategoryVO;
import com.babee.goods.vo.GoodsQNA;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;

@Mapper
@Repository("goodsDAO")
public interface GoodsDAO {

	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	public ImageFileVO selectGoodsDetailImage(String goods_id) throws DataAccessException;
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;
	//상품조회
	public List<GoodsVO> selectAllGoods(@Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	public int selectAllGoodsCount() throws DataAccessException;
	//
	public List<GoodsQNA> selectAllGoodsQna(String goods_id) throws DataAccessException;
	public List<GoodsVO> selectAllCategoryGoods(Map goods) throws DataAccessException;
	public List getAllcg(CategoryVO category) throws DataAccessException;
	public void insertGoodsQNA(GoodsQNA goodsQNA) throws DataAccessException;
	public void deleteGoodsQNA(GoodsQNA goodsQNA) throws DataAccessException;
	
	public List<GoodsVO> seasonGoodsList() throws DataAccessException;
	public List selectFitGodos(String baby_age) throws DataAccessException;
	//상품 옵션조회
	public List<GoodsVO> selectSort(@Param("sort") String sort,@Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	public int selectSortCount() throws DataAccessException;
	public List<GoodsVO> hotGoodsList(@Param("startIndex") int startIndex, @Param("itemsPerPage") int itemsPerPage) throws DataAccessException;
	public int hotGoodsListCount() throws DataAccessException;
	//
	public List<GoodsVO> hotGoodsListMain() throws DataAccessException;
	public Map<String,String> getsubcg(String sub_category) throws DataAccessException;
	public GoodsVO getGoods(String goods_id) throws DataAccessException;

	public void reviewStatus(String goods_id)throws DataAccessException;
	
}
