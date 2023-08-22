package com.babee.goods.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.h2.util.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
import com.babee.goods.service.GoodsService;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;
import com.babee.mypage.service.MyPageService;
import com.babee.mypage.vo.ReviewVO;

@Controller("goodsController")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController implements GoodsController {
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private MyPageService mypageService;
	
	
	@RequestMapping(value="/goodsDetail.do" ,method = RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		Map goodsMap=goodsService.goodsDetail(goods_id);
		ModelAndView mav = new ModelAndView(viewName);
		GoodsVO goodsVO = (GoodsVO)goodsMap.get("goodsVO");
		List<ReviewVO> reviewList = mypageService.selectGoodsReview(goods_id);
		mav.addObject("goodsVO", goodsVO);
		mav.addObject("review", reviewList);
		return mav;
	}
	

	 @RequestMapping(value="/goodsList.do", method = RequestMethod.GET)
	   public ModelAndView goodsList(HttpServletRequest request, HttpServletResponse response) throws Exception {      
	       ModelAndView mav = new ModelAndView("/goods/goodsList"); 
	       List<GoodsVO> newGoodsList = goodsService.getAllGoods();
	       mav.addObject("newGoodsList", newGoodsList);
	       return mav;
	   }
	   //end
	 @RequestMapping(value="/goodsCategoryList.do", method = RequestMethod.GET)
	 public ModelAndView goodsCategoryList(@RequestParam(required = false) Map<String, String> category,HttpServletRequest request, HttpServletResponse response) throws Exception {     
		 ModelAndView mav = new ModelAndView("/goods/goodsList"); // 수정된 부분
		 System.out.println(category.get("main_category"));
		 List<GoodsVO> newGoodsList = goodsService.getAllCategoryGoods(category);
		 mav.addObject("newGoodsList", newGoodsList); 
		 return mav;
	 }
	 //end

	
	@RequestMapping(value="/searchGoods.do" ,method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		return mav;
		
	}
	
}
