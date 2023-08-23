package com.babee.goods.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
import com.babee.goods.service.GoodsService;
import com.babee.goods.vo.CategoryVO;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.GoodsQNA;
import com.babee.goods.vo.GoodsVO;
import com.babee.member.vo.MemberVO;
import com.babee.mypage.service.MyPageService;
import com.babee.mypage.vo.ReviewVO;

@Controller("goodsController")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController implements GoodsController {
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private MyPageService mypageService;
	@Autowired
	private GoodsQNA goodsQNA;
	
	
	@RequestMapping(value="/goodsDetail.do" ,method = RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		Map goodsMap=goodsService.goodsDetail(goods_id);
		ModelAndView mav = new ModelAndView(viewName);
		GoodsVO goodsVO = (GoodsVO)goodsMap.get("goodsVO");
		List<ReviewVO> reviewList = mypageService.selectGoodsReview(goods_id);
		List<GoodsQNA> qnaList = goodsService.getAllGoodsQna(goods_id);
		mav.addObject("goodsVO", goodsVO);
		mav.addObject("review", reviewList);
		mav.addObject("qna", qnaList);
		return mav;
	}
	
	@RequestMapping(value="/goodsQna.do" ,method = RequestMethod.POST)
	public ModelAndView goodsQna(@ModelAttribute("goodsQNA")GoodsQNA goodsQNA,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		//사용자 상품 문의글 작성 컨트롤러
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("memberInfo");
		String member_id = member.getMember_id();
		goodsQNA.setMember_id(member_id);
		goodsService.insertGoodsQNA(goodsQNA);
		String goods_id=goodsQNA.getGoods_id();
		mav.setViewName("redirect:/goods/goodsDetail.do?goods_id="+goods_id);
		return mav;
	}
	
	 @RequestMapping(value="/goodsList.do", method = RequestMethod.GET)
	   public ModelAndView goodsList(HttpServletRequest request, HttpServletResponse response) throws Exception {      
	       ModelAndView mav = new ModelAndView("/goods/goodsList"); 
	       List<GoodsVO> newGoodsList = goodsService.getAllGoods();
	       
	       List<CategoryVO> allCategories = goodsService.getAllcg();
	       mav.addObject("newGoodsList", newGoodsList);
	       mav.addObject("allCategories", allCategories);
	       return mav;
	   }
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
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		return mav;
		
	}
	
}
