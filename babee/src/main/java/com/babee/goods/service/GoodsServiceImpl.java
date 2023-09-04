package com.babee.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.babee.goods.dao.GoodsDAO;
import com.babee.goods.vo.CategoryVO;
import com.babee.goods.vo.GoodsQNA;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	
	//상품조회
	@Override
    public List<GoodsVO> getAllGoods(int startIndex, int itemsPerPage) throws Exception {
        return goodsDAO.selectAllGoods(startIndex, itemsPerPage);  
    }
	@Override
	public int selectAllGoodsCount() throws Exception{
		return goodsDAO.selectAllGoodsCount();
	}
	
	@Override
	public List<GoodsQNA> getAllGoodsQna(String goods_id) throws Exception {
		return goodsDAO.selectAllGoodsQna(goods_id);  
	}
	
	@Override
	public List<GoodsVO> getAllCategoryGoods(Map goods) {
		return goodsDAO.selectAllCategoryGoods(goods);  
	}
	
	@Override
	public Map goodsDetail(String _goods_id) throws Exception {
		Map goodsMap=new HashMap();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		//List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
		//goodsMap.put("imageList", imageList);
		return goodsMap;
	}
	
	@Override
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		return list;
	}
	
	@Override
	public ImageFileVO goodsDetailImage(String member_id) throws Exception {
		ImageFileVO image= goodsDAO.selectGoodsDetailImage(member_id);
		return image;
	}
	
	@Override
	public List<GoodsVO> searchGoods(String searchWord) throws Exception{
		List goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}
	@Override
	public void insertGoodsQNA(GoodsQNA goodsQNA) throws Exception{
		goodsDAO.insertGoodsQNA(goodsQNA);
	}

	@Override
	public void deleteGoodsQNA(GoodsQNA goodsQNA) throws Exception{
		goodsDAO.deleteGoodsQNA(goodsQNA);
	}

	@Override
	public List<CategoryVO> getAllcg(CategoryVO category) throws Exception {
        return goodsDAO.getAllcg(category);
    }
	//상품옵션조회
	@Override
	public List<GoodsVO> hotGoodsList(int startIndex, int itemsPerPage)throws Exception{
		return goodsDAO.hotGoodsList(startIndex, itemsPerPage);
	}
	@Override
	public int hotGoodsListCount() throws Exception{
		return goodsDAO.hotGoodsListCount();
	}
	@Override
	public List<GoodsVO> selectSort(String sort,int startIndex, int itemsPerPage) throws Exception{
		return goodsDAO.selectSort(sort, startIndex,itemsPerPage);
	}
	@Override
	public int selectSortCount() throws Exception{
		return goodsDAO.selectAllGoodsCount();
	}
	//
	@Override
	public List<GoodsVO> hotGoodsListMain() throws Exception{
		return goodsDAO.hotGoodsListMain();
	}
	@Override
	public List<GoodsVO> seasonGoodsList()throws Exception{
		return goodsDAO.seasonGoodsList();
		
	}
	@Override
	public List getfitList(String baby_age) throws Exception{
		return goodsDAO.selectFitGodos(baby_age);
	}
	@Override
	public Map<String, String> getsubcg(String sub_category) throws Exception{
		return goodsDAO.getsubcg(sub_category);
	}
	@Override
	public void reviewStatus(String goods_id) {
		goodsDAO.reviewStatus(goods_id);
		
	}
}
