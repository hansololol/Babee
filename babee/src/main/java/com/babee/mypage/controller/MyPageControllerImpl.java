package com.babee.mypage.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
import com.babee.goods.service.GoodsService;
import com.babee.goods.vo.GoodsVO;
import com.babee.member.vo.MemberVO;
import com.babee.mypage.service.MyPageService;
import com.babee.order.vo.OrderVO;
import com.babee.order.vo.RefundVO;

@Controller("myPageController")
@RequestMapping(value="/mypage")
public class MyPageControllerImpl extends BaseController  implements MyPageController{
	@Autowired
	private MyPageService myPageService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private OrderVO orderVO;
	
	@Override
	@RequestMapping(value="/myPageMain.do" ,method = RequestMethod.GET)
	public ModelAndView myPageMain(
			   HttpServletRequest request, HttpServletResponse response)  throws Exception {
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/myOrderDetail.do" ,method = RequestMethod.GET)
	public ModelAndView myOrderDetail(@RequestParam("order_id")  String order_id,HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		MemberVO orderer=(MemberVO)session.getAttribute("memberInfo");
		List<OrderVO> myOrderList=myPageService.findMyOrderInfo(order_id);
		mav.addObject("myOrderList",myOrderList);
		orderVO = myOrderList.get(0);
		mav.addObject("myOrder",orderVO);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/listMyOrderHistory.do" ,method = RequestMethod.GET)
	public ModelAndView listMyOrderHistory(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String  member_id=memberVO.getMember_id();
		
		String _section = request.getParameter("section");
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt(((_section==null)? "1":_section));
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
	
		
		List<OrderVO> myOrderListGoods=myPageService.listMyOrderGoods(member_id);
		List<OrderVO> myOrderList = new ArrayList<>();
		int ListSize = myOrderListGoods.size();
		SimpleDateFormat format= new SimpleDateFormat("yyyy-MM-dd");
	
		Date now = new Date();
		if(request.getParameter("beginDate")!=null) {
			String beginDateS = request.getParameter("beginDate");
			now=  (Date)format.parse(beginDateS);
			System.out.println(now + "시작 일 확인");
		}else {
			now = new Date(System.currentTimeMillis());
			System.out.println(now);
		}
		
		for(int i =(pageNum-1)*10; i <ListSize;i++) {
			orderVO = myOrderListGoods.get(i);
				
			String goods_id = orderVO.getGoods_id();
			Map goodsVOMap = goodsService.goodsDetail(goods_id);
			GoodsVO goodsVO = (GoodsVO)goodsVOMap.get("goodsVO");
			String img_id= goodsVO.getGoods_image_name1();
			orderVO.setGoods_image_name(img_id);
			Date orderTime =  orderVO.getPayment_order_time();
	
			myOrderList.add(orderVO);

		}
		mav.addObject("myOrderList", myOrderList);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("totArticles", ListSize);
	
		return mav;
	}	
	
	@Override
	@RequestMapping(value="/cancelMyOrder.do" ,method = RequestMethod.GET)
	public ModelAndView cancelMyOrder(@RequestParam("order_id")  String order_id,
			                         HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		myPageService.cancelOrder(order_id);
		mav.setViewName("redirect:/mypage/listMyOrderHistory.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/myrefund.do" ,method = RequestMethod.GET)
	public ModelAndView myrefund(@RequestParam("order_id") String order_id,
			HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		List OrderListAll = myPageService.findMyOrderInfo(order_id);
	
		List OrderList = new ArrayList<>();
		for(int i=0; i<OrderListAll.size(); i++) {
			OrderVO orderVO = (OrderVO) OrderListAll.get(i);
			System.out.println(orderVO.getDelivery_status() +"출력 확인");
			Map goods = goodsService.goodsDetail(orderVO.getGoods_id());
			GoodsVO goodsVO = (GoodsVO) goods.get("goodsVO");
			orderVO.setGoods_title(goodsVO.getGoods_title());
			orderVO.setGoods_image_name(goodsVO.getGoods_image_name1());
			OrderList.add(orderVO);
		}
		HttpSession session=request.getSession();
		session.setAttribute("orderList", OrderList);
		return mav;
	}
	@Override
	@RequestMapping(value="/refundOrder.do" ,method = RequestMethod.POST)
	public ModelAndView refundOrder(@ModelAttribute("refundVO") RefundVO refund,
			HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		refund.setMember_id(memberVO.getMember_id());
		myPageService.refundOrder(refund);
		mav.setViewName("redirect:/mypage/listMyOrderHistory.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/myDetailInfo.do" ,method = RequestMethod.GET)
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}	
	
	
	
}
