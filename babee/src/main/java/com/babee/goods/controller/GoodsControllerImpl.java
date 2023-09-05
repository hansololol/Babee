package com.babee.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
		String number=request.getParameter("num");
		List<GoodsQNA> qnaList = goodsService.getAllGoodsQna(goods_id);
		if(number!=null) {
			int num = Integer.parseInt(number);
			goodsQNA =qnaList.get(num);
			goodsService.deleteGoodsQNA(goodsQNA);
		}
		List<ReviewVO> reviewList = mypageService.selectGoodsReview(goods_id);
		qnaList = goodsService.getAllGoodsQna(goods_id);
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
	
	@RequestMapping(value = "/goodsList.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView goodsList(HttpServletRequest request, HttpServletResponse response,
	        @RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {

	    request.setCharacterEncoding("utf-8");
	    ModelAndView mav = new ModelAndView("/goods/goodsList");
	    int itemsPerPage = 15;
	    int startIndex = (currentPage - 1) * itemsPerPage;
	    
	    // 현재 정렬 방식을 request 파라미터에서 읽어옴
	    String sort = request.getParameter("sort");
	    if (sort == null) {
	        sort = "defaultSort"; // 정렬 방식이 선택되지 않았을 때 기본값 설정
	    }

	    // 정렬 방식에 따라 상품 목록을 가져옴
	    List<GoodsVO> newGoodsList = null;
	    int totalItemCount = 0;

	    switch (sort) {
	        case "new":
	            newGoodsList = goodsService.selectSort("new", startIndex, itemsPerPage);
	            totalItemCount = goodsService.selectSortCount();
	            break;

	        case "popular":
	            newGoodsList = goodsService.hotGoodsList(startIndex, itemsPerPage);
	            totalItemCount = goodsService.hotGoodsListCount();
	            break;

	        case "low":
	            newGoodsList = goodsService.selectSort("low", startIndex, itemsPerPage);
	            totalItemCount = goodsService.selectSortCount();
	            break;

	        case "high":
	            newGoodsList = goodsService.selectSort("high", startIndex, itemsPerPage);
	            totalItemCount = goodsService.selectSortCount();
	            break;
	            
	        default: // 정렬 방식이 선택되지 않았거나 올바르지 않은 값일 때
	            newGoodsList = goodsService.getAllGoods(startIndex, itemsPerPage);
	            totalItemCount = goodsService.selectAllGoodsCount();
	            sort = "defaultSort"; // 기본값 설정
	            break;
	    }

	    int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);

	    mav.addObject("totalPages", totalPages);
	    mav.addObject("currentPage", currentPage);
	    mav.addObject("newGoodsList", newGoodsList);
	    mav.addObject("sort", sort); // 현재 정렬 방식을 뷰로 전달

	    return mav;
	}
	   //end
	 @RequestMapping(value="/goodsCategoryList.do", method = RequestMethod.GET)
	 public ModelAndView goodsCategoryList(@RequestParam(required = false) Map<String, String> category,HttpServletRequest request, HttpServletResponse response) throws Exception {     
		 request.setCharacterEncoding("utf-8");
		 ModelAndView mav = new ModelAndView("/goods/goodsList");
		 String sort = request.getParameter("sort");
		 List<GoodsVO> newGoodsList = new ArrayList<>();
		 newGoodsList =  goodsService.getAllCategoryGoods(category);
	       if(sort!=null) {
	    	  switch(sort) {
	    	  case "new" :
	    		  category.put("sort", "goods_creation_date desc");
	    		  newGoodsList=goodsService.getAllCategoryGoods(category);
	    	  	break;
	    	  	
	    	  case "popular":
	    		  newGoodsList = goodsService.getAllCategoryGoods(category);
	    		  System.out.println("인기상풍 목록");
	    		  break;
	    		  
	    	  case "low":
	    		  category.put("sort", "goods_price");
	    		  newGoodsList= goodsService.getAllCategoryGoods(category);
	    		  break;
	    		  
	    	  case "high":
	    		  category.put("sort", "goods_price");
	    		  newGoodsList= goodsService.getAllCategoryGoods(category);
	    		  break;
	    	  }
	       }
		 categoryVO.setMain_category(category.get("main_category"));
		 String middle = category.get("middle_category");
		 if(middle != null || middle != "") {
		 categoryVO.setMiddle_category(category.get("middle_category"));
		 }
		 List sub_category= goodsService.getAllcg(categoryVO);
		 mav.addObject("newGoodsList", newGoodsList); 
		 mav.addObject("category", category);
		 mav.addObject("sub_category", sub_category);
		 return mav;
	 }
	 //end

	
	@RequestMapping(value="/searchGoods.do" ,method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView("/goods/goodsList");
		List goodsList=goodsService.searchGoods(searchWord);
		if(goodsList.size()!=0) {
		GoodsVO goodsVO =  (GoodsVO) goodsList.get(0);
		String main_category = goodsVO.getMain_category();
		String middle_category=goodsVO.getMiddle_category();
		categoryVO.setMain_category(main_category);
		categoryVO.setMiddle_category(middle_category);
		List sub_category= goodsService.getAllcg(categoryVO);
		mav.addObject("sub_category", sub_category);
		mav.addObject("category", categoryVO);
		mav.addObject("newGoodsList", goodsList);
		}
		return mav;
		
	}
	@RequestMapping(value="/fitGoods.do" ,method = RequestMethod.GET)
	public ModelAndView fitGoods(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		
		int itemsPerPage = 15;
	    int startIndex = (currentPage - 1) * itemsPerPage;
		
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
		
		System.out.println(sub_category + "서브");
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
		
	   
	    
	    // 현재 정렬 방식을 request 파라미터에서 읽어옴
	    String sort = request.getParameter("sort");
	    if (sort == null) {
	        sort = "defaultSort"; // 정렬 방식이 선택되지 않았을 때 기본값 설정
	    }

	    // 정렬 방식에 따라 상품 목록을 가져옴
	    List<GoodsVO> newGoodsList = null;
	    int totalItemCount = 0;

	    switch (sort) {
	        case "new":
	            newGoodsList = goodsService.selectSort("new", startIndex, itemsPerPage);
	            totalItemCount = goodsService.selectSortCount();
	            break;

	        case "popular":
	            newGoodsList = goodsService.hotGoodsList(startIndex, itemsPerPage);
	            totalItemCount = goodsService.hotGoodsListCount();
	            break;

	        case "low":
	            newGoodsList = goodsService.selectSort("low", startIndex, itemsPerPage);
	            totalItemCount = goodsService.selectSortCount();
	            break;

	        case "high":
	            newGoodsList = goodsService.selectSort("high", startIndex, itemsPerPage);
	            totalItemCount = goodsService.selectSortCount();
	            break;
	            
	        default: // 정렬 방식이 선택되지 않았거나 올바르지 않은 값일 때
	            newGoodsList = goodsService.getAllGoods(startIndex, itemsPerPage);
	            totalItemCount = goodsService.selectAllGoodsCount();
	            sort = "defaultSort"; // 기본값 설정
	            break;
	    }

	    int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);

	    mav.addObject("totalPages", totalPages);
	    

	   
	    mav.addObject("currentPage", currentPage);
		mav.addObject("goods", goodsList);
		
		
		
		return mav;
		
	}
	
}
