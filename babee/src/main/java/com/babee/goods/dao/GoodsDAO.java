package com.babee.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;

@Mapper
@Repository("goodsDAO")
public interface GoodsDAO {

	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	public ImageFileVO selectGoodsDetailImage(String goods_id) throws DataAccessException;
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;
	public List<GoodsVO> selectAllGoods() throws DataAccessException;
	public List<GoodsVO> selectAllCategoryGoods(Map goods) throws DataAccessException;
}
