package com.babee.mypage.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
import com.babee.goods.service.GoodsService;
import com.babee.goods.vo.GoodsVO;
import com.babee.member.vo.MemberVO;
import com.babee.mypage.service.MyPageService;
import com.babee.mypage.vo.ReviewVO;
import com.babee.mypage.vo.WishVO;
import com.babee.order.vo.OrderVO;
import com.babee.order.vo.RefundVO;
import com.babee.seller.vo.SellerVO;

@Controller("myPageController")
@RequestMapping(value = "/mypage")
public class MyPageControllerImpl extends BaseController implements MyPageController {
	@Autowired
	private MyPageService myPageService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private OrderVO orderVO;
	@Autowired

	private WishVO wishVO;

	private ReviewVO reviewVO;

	private static String ARTICLE_IMAGE_REPO = "c:/shopping/review";

	@Override
	@RequestMapping(value = "/myPageMain.do", method = RequestMethod.GET)
	public ModelAndView myPageMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

	
	@Override
	@RequestMapping(value = "/myOrderDetail.do", method = RequestMethod.GET)
	public ModelAndView myOrderDetail(@RequestParam("order_id") String order_id, HttpServletRequest request,
	        HttpServletResponse response) throws Exception {
	    String viewName = (String) request.getAttribute("viewName");
	    ModelAndView mav = new ModelAndView(viewName);
	    HttpSession session = request.getSession();
	    
	    // 사용자의 역할에 따라서 적절한 캐스팅을 수행
	    Object memberInfo = session.getAttribute("memberInfo");
	    if (memberInfo instanceof MemberVO) {
	        MemberVO orderer = (MemberVO) memberInfo;
	        List<OrderVO> myOrderList = myPageService.findMyOrderInfo(order_id);
	        
	        for (OrderVO orderVO : myOrderList) {
	            String goods_id = orderVO.getGoods_id();
	            Map goodsVOMap = goodsService.goodsDetail(goods_id);
	            GoodsVO goodsVO = (GoodsVO) goodsVOMap.get("goodsVO");
	            String goods_title = goodsVO.getGoods_title();
	            String goods_image_name1 = goodsVO.getGoods_image_name1();
	            orderVO.setGoods_title(goods_title);
	            orderVO.setGoods_image_name(goods_image_name1);
	        }
	        
	        mav.addObject("myOrderList", myOrderList);
	        orderVO = myOrderList.get(0);
	        mav.addObject("myOrder", orderVO);
	    } else if (memberInfo instanceof SellerVO) {
	        SellerVO sellerVO = (SellerVO) memberInfo;
	        // 셀러에 관련된 로직 수행
	        List<OrderVO> myOrderList = myPageService.findMyOrderInfo(order_id);
	        mav.addObject("myOrderList", myOrderList);
	        orderVO = myOrderList.get(0);
	        mav.addObject("myOrder", orderVO);
	    }
	    
	    return mav;
	}

	@Override
	@RequestMapping(value = "/listMyOrderHistory.do", method = RequestMethod.GET)
	public ModelAndView listMyOrderHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		Object member = session.getAttribute("memberInfo");
		String member_id = null;
		if(member instanceof MemberVO) {
			member_id = ((MemberVO) member).getMember_id();
		}else if(member instanceof SellerVO) {
			member_id = ((SellerVO)member).getSeller_id();
		}
	
		String _section = request.getParameter("section");
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt(((_section == null) ? "1" : _section));
		int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));

		List<OrderVO> myOrderListGoods = myPageService.listMyOrderGoods(member_id);
		List<OrderVO> myOrderList = new ArrayList<>();
		int ListSize = myOrderListGoods.size();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		Date now = new Date();
		if (request.getParameter("beginDate") != null) {
			String beginDateS = request.getParameter("beginDate");
			now = (Date) format.parse(beginDateS);

		} else {
			now = new Date(System.currentTimeMillis());

		}

		for (int i = (pageNum - 1) * 10; i < pageNum * 10; i++) {
			try {
				orderVO = myOrderListGoods.get(i);
				String goods_id = orderVO.getGoods_id();
				Map goodsVOMap = goodsService.goodsDetail(goods_id);
				GoodsVO goodsVO = (GoodsVO) goodsVOMap.get("goodsVO");
				String img_id = goodsVO.getGoods_image_name1();
				orderVO.setGoods_image_name(img_id);
				Date orderTime = orderVO.getPayment_order_time();
				myOrderList.add(orderVO);
			} catch (IndexOutOfBoundsException e) {
				break;
			}
		}

		mav.addObject("myOrderList", myOrderList);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("totArticles", ListSize);

		return mav;
	}

	@Override
	@RequestMapping(value = "/cancelMyOrder.do", method = RequestMethod.GET)
	public ModelAndView cancelMyOrder(@RequestParam("order_id") String order_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		myPageService.cancelOrder(order_id);
		mav.setViewName("redirect:/mypage/listMyOrderHistory.do");
		return mav;
	}

	@Override
	@RequestMapping(value = "/myrefund.do", method = RequestMethod.GET)
	public ModelAndView myrefund(@RequestParam("order_id") String order_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		List OrderListAll = myPageService.findMyOrderInfo(order_id);

		List OrderList = new ArrayList<>();
		for (int i = 0; i < OrderListAll.size(); i++) {
			OrderVO orderVO = (OrderVO) OrderListAll.get(i);

			Map goods = goodsService.goodsDetail(orderVO.getGoods_id());
			GoodsVO goodsVO = (GoodsVO) goods.get("goodsVO");
			orderVO.setGoods_title(goodsVO.getGoods_title());
			orderVO.setGoods_image_name(goodsVO.getGoods_image_name1());
			OrderList.add(orderVO);
		}
		HttpSession session = request.getSession();
		session.setAttribute("orderList", OrderList);
		orderVO = (OrderVO) OrderListAll.get(0);
		mav.addObject("orderVO", orderVO);
		return mav;
	}

	@Override
	@RequestMapping(value = "/refundOrder.do", method = RequestMethod.POST)
	public ModelAndView refundOrder(@ModelAttribute("refundVO") RefundVO refund, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		refund.setMember_id(memberVO.getMember_id());
		myPageService.refundOrder(refund);
		mav.setViewName("redirect:/mypage/listMyOrderHistory.do");
		return mav;
	}

	@Override
	@RequestMapping(value = "/reviewWrite.do", method = RequestMethod.POST)
	public ModelAndView reviewWrite(@ModelAttribute("reviewVO") ReviewVO review,
			MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		Object member = session.getAttribute("memberInfo");
		String member_id = null;
		if(member instanceof MemberVO) {
			member_id = ((MemberVO) member).getMember_id();
		}else if(member instanceof SellerVO) {
			member_id = ((SellerVO) member).getSeller_id();
		}
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			reviewMap.put(name, value);
			System.out.println(reviewMap);
		}
		List imageFileName = upload(multipartRequest);
		reviewMap.put("review_img", imageFileName.get(0));
		int img_id = (int) Math.floor(Math.random() * 1000000);
		String review_img_id = String.valueOf(img_id);
		reviewMap.put("review_img_id", review_img_id);
		
		
		String goods_id = review.getGoods_id();
		goodsService.reviewStatus(goods_id);
		

		try {

			myPageService.addReview(reviewMap);
			if (imageFileName != null && imageFileName.size() != 0) {
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName.get(0));
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + member_id);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				mav.setViewName("redirect:/mypage/myReviewList.do");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/myDetailInfo.do", method = RequestMethod.GET)
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

	@Override
	@RequestMapping(value = "/removeGoodsReview.do", method = RequestMethod.POST)
	public ModelAndView removeGoodsReview(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 상품 리뷰 상세 컨트롤러
		String goods_id = request.getParameter("goods_id");
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		Map reviewMap = new HashMap<>();
		reviewMap.put("member_id", member_id);
		reviewMap.put("goods_id", goods_id);
		myPageService.delReview(reviewMap);
		
		String goods_img = request.getParameter("goods_img");
		System.out.println(goods_img + "상품 이미지 확인");
		if(goods_img!=null) {
			File path = new File("C:/shopping/review" + "/" + member_id + "/" + goods_img);
			path.delete();
		}
		ModelAndView mav = new ModelAndView("redirect:/mypage/myReviewList.do");
		return mav;
	}

	@Override
	@RequestMapping(value = "/myReviewList.do", method = RequestMethod.GET)
	public ModelAndView myReviewList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		String _section = request.getParameter("section");
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt(((_section == null) ? "1" : _section));
		int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));

		Object member = session.getAttribute("memberInfo");
		String member_id = null;
		if(member instanceof MemberVO) {
			member_id = ((MemberVO) member).getMember_id();
		}else if(member instanceof SellerVO) {
			member_id = ((SellerVO) member).getSeller_id();
		}
		List myReview = myPageService.selectReview(member_id);
		List review = new ArrayList<>();
		int ListSize = myReview.size();
		String kewWord = request.getParameter("reviewTitle");
		for (int i = (pageNum - 1) * 10; i < pageNum * 10; i++) {
			try {
				reviewVO = (ReviewVO) myReview.get(i);
				if(kewWord != null ) {
						String goods_id = reviewVO.getGoods_id();
						Map goods =goodsService.goodsDetail(goods_id);
						GoodsVO goodsVO =(GoodsVO) goods.get("goodsVO");
						if(goodsVO.getGoods_title().contains(kewWord)) {
						reviewVO.setGoodsVO(goodsVO);
						review.add(reviewVO);
					}
				}else {
					String goods_id = reviewVO.getGoods_id();
					Map goods =goodsService.goodsDetail(goods_id);
					GoodsVO goodsVO =(GoodsVO) goods.get("goodsVO");
					reviewVO.setGoodsVO(goodsVO);
					review.add(reviewVO);
				}
				
			} catch (IndexOutOfBoundsException e) {
				break;
			}
		}
		
		mav.addObject("review", review);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("totArticles", ListSize);
		return mav;
	}

	@Override
	@RequestMapping(value = "/wishList.do", method = RequestMethod.GET)
	public ModelAndView wishList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		HttpSession session = request.getSession();
		String userType = (String) session.getAttribute("userType");
		// 로그인한 사용자 ID 가져오기(memberId)
		List<WishVO> myWishList = new ArrayList<>();
	
		if (userType.equals("M")) {
			MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
			String member_id = memberVO.getMember_id();

			myWishList = myPageService.selectWishList(member_id);
			  for(int i=0; i<myWishList.size(); i++) { 
				  wishVO = myWishList.get(i);
				  int  goods_id = wishVO.getGoods_id(); String id= String.valueOf(goods_id); 
				  Map  goods = goodsService.goodsDetail(id); 
				  GoodsVO goodsCart = (GoodsVO) goods.get("goodsVO"); 
				  wishVO.setGoods_title(goodsCart.getGoods_title());
			  wishVO.setGoods_price(goodsCart.getGoods_price());
			  wishVO.setGoods_image_name1(goodsCart.getGoods_image_name1()); 
			  
			  }
			 

		} else if (userType.equals("S")) {
			SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
			String member_id = sellerVO.getSeller_id();

			myWishList = myPageService.selectWishList(member_id);
			  for(int i=0; i<myWishList.size(); i++) { 
				  wishVO = myWishList.get(i);
				  int  goods_id = wishVO.getGoods_id(); String id= String.valueOf(goods_id); 
				  Map  goods = goodsService.goodsDetail(id); 
				  GoodsVO goodsCart = (GoodsVO) goods.get("goodsVO"); 
				  wishVO.setGoods_title(goodsCart.getGoods_title());
			  wishVO.setGoods_price(goodsCart.getGoods_price());
			  wishVO.setGoods_image_name1(goodsCart.getGoods_image_name1()); 
			  
			  }

		}

		mav.addObject("myWishList", myWishList);
		
		return mav;
	}

	@PostMapping("addWishList")
	@ResponseBody
	public String addWishList(@RequestBody WishVO wishVO, HttpServletRequest request, HttpSession session)
			throws Exception {

		boolean isAreadyExisted = myPageService.findWishList(wishVO);

		if (isAreadyExisted == true) {
			return "already_existed";

		} else {
			myPageService.addWishList(wishVO);
			return "add_success";
		}
	}

	@RequestMapping(value = "/removeWishList.do", method = RequestMethod.POST)
	public ModelAndView removeWishList(@RequestParam("articleNO") int articleNO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		myPageService.removeWishList(articleNO);
		mav.setViewName("redirect:/mypage/wishList.do");
		return mav;
	}

	protected List upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		List imageFileName = new ArrayList();
		Iterator<String> fileNames = multipartRequest.getFileNames();

		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String imgfname = mFile.getOriginalFilename();
			imageFileName.add(imgfname);
			File file = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileName);
			if (mFile.getSize() != 0) {
				if (!file.exists()) {
					file.getParentFile().mkdirs();
					mFile.transferTo(new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imgfname));
				}
			}
		}
		return imageFileName;
	}

}
