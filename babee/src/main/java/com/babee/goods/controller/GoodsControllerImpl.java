package com.babee.goods.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
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
	@Autowired
	private CategoryVO categoryVO;
	
	
	@RequestMapping(value="/goodsDetail.do" ,method = RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		Map goodsMap=goodsService.goodsDetail(goods_id);
		ModelAndView mav = new ModelAndView(viewName);
		GoodsVO goodsVO = (GoodsVO)goodsMap.get("goodsVO");
		List<ReviewVO> reviewList = mypageService.selectGoodsReview(goods_id);
		List<GoodsQNA> qnaList = goodsService.getAllGoodsQna(goods_id);
		String number=request.getParameter("num");
		if(number!=null) {
			int num = Integer.parseInt(number);
			goodsQNA =qnaList.get(num);
			goodsService.deleteGoodsQNA(goodsQNA);
		}
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
	       mav.addObject("newGoodsList", newGoodsList);
	       return mav;
	   }
	   //end
	 @RequestMapping(value="/goodsCategoryList.do", method = RequestMethod.GET)
	 public ModelAndView goodsCategoryList(@RequestParam(required = false) Map<String, String> category,HttpServletRequest request, HttpServletResponse response) throws Exception {     
		 request.setCharacterEncoding("utf-8");
		 ModelAndView mav = new ModelAndView("/goods/goodsList"); // 수정된 부분
		 List<GoodsVO> newGoodsList = goodsService.getAllCategoryGoods(category);
		 categoryVO.setMain_category(category.get("main_category"));
		 String middle = category.get("middle_category");
		 if(middle !=null) {
		 categoryVO.setMiddle_category(category.get("middle_category"));
		 }
		 List sub_category= goodsService.getAllcg(categoryVO);
		 mav.addObject("newGoodsList", newGoodsList); 
		 mav.addObject("category", category);
		 mav.addObject("sub_category", sub_category);
		 System.out.println(sub_category.get(0)+ "서브 카테고리 확인");
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
	@RequestMapping(value="/fitGoods.do" ,method = RequestMethod.GET)
	public ModelAndView fitGoods(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("memberInfo");
		String baby_age = member.getBaby_age();
		List fitList = goodsService.getfitList(baby_age);
		mav.addObject("fit", fitList);
		Map sub_c = (Map) fitList.get(0);
		String sub_category = (String) sub_c.get("sub_category");
		String sub = request.getParameter("sub_category");
		if(sub !=null) {
			sub_category = sub;
		}
		Map<String, String> category = goodsService.getsubcg(sub_category);
		String main_category = category.get("main_category");
		String middle_category = category.get("middle_category");
		main_category =  main_category.trim();
		middle_category = sub_category.trim();
		Map<String, String> cate = new HashedMap();
		cate.put("main_category", main_category);
		cate.put("middle_category", middle_category);
		List<GoodsVO> goodsList = goodsService.getAllCategoryGoods(category);
		System.out.println(goodsList.size() + "상품 사이즈 확인");
		mav.addObject("goods", goodsList);
		return mav;
		
	}
	
}
