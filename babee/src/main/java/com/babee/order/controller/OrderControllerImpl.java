package com.babee.order.controller;

import java.util.ArrayList;
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
import com.babee.order.service.OrderService;
import com.babee.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private OrderVO orderVO;

	
	@RequestMapping(value="/orderEachGoods.do" , method=RequestMethod.POST)
	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO orderVO,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{		
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		ModelAndView mav = new ModelAndView("/goods/orderGoodsForm");
		Map goodsVO1=goodsService.goodsDetail(orderVO.getGoods_id());
		GoodsVO goodsVO =(GoodsVO)goodsVO1.get("goodsVO");

		int order_goods_qty = Integer.valueOf(orderVO.getOrder_goods_qty());
		int goods_price = Integer.valueOf(goodsVO.getGoods_price());
		int discounted_price = (goods_price / 10) * order_goods_qty;
		int total_goods_price = goods_price * order_goods_qty;
		mav.addObject("total_goods_price", total_goods_price);
		mav.addObject("discounted_price", discounted_price);

		List ordergoods = new ArrayList<>();
		ordergoods.add(orderVO);
		session.setAttribute("goods", goodsVO);
		session.setAttribute("orderInfo", ordergoods);
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	 * public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")
	 * String[] cart_goods_qty, HttpServletRequest request, HttpServletResponse
	 * response) throws Exception{ String
	 * viewName=(String)request.getAttribute("viewName"); ModelAndView mav = new
	 * ModelAndView(viewName); HttpSession session=request.getSession(); Map
	 * cartMap=(Map)session.getAttribute("cartMap"); List myOrderList=new
	 * ArrayList<OrderVO>();
	 * 
	 * List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList"); MemberVO
	 * memberVO=(MemberVO)session.getAttribute("memberInfo");
	 * 
	 * for(int i=0; i<cart_goods_qty.length;i++){ String[]
	 * cart_goods=cart_goods_qty[i].split(":"); for(int j = 0; j<
	 * myGoodsList.size();j++) { GoodsVO goodsVO = myGoodsList.get(j); String
	 * goods_id = goodsVO.getGoods_id();
	 * if(goods_id==Integer.parseInt(cart_goods[0])) { OrderVO _orderVO=new
	 * OrderVO(); String goods_title=goodsVO.getGoods_title();
	 * 
	 * _orderVO.setGoods_id(goods_id); _orderVO.setGoods_title(goods_title);
	 * 
	 * _orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));
	 * myOrderList.add(_orderVO); break; } } } session.setAttribute("myOrderList",
	 * myOrderList); session.setAttribute("orderer", memberVO); return mav; }
	 */
	@RequestMapping(value="/payToOrderGoods.do" ,method = RequestMethod.POST)
	public ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{

		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
	
		
		String member_id=memberVO.getMember_id();
		String recipient_hp = memberVO.getMember_hp1()+"-"+memberVO.getMember_hp2()+"-"+memberVO.getMember_hp3();
		String recipient_tel = memberVO.getMember_tel1()+"-"+memberVO.getMember_tel2()+"-"+memberVO.getMember_tel3();
		String deliveryAddr = receiverMap.get("member_zipcode") + receiverMap.get("member_roadAddr") + receiverMap.get("member_jibunAddr") + receiverMap.get("member_namujiAddr");
		List<OrderVO> myOrderList=(List<OrderVO>)session.getAttribute("orderInfo");
		int randomNO = (int)Math.floor(Math.random()*100000000);
		String order_id = String.valueOf(randomNO);
		int total_goods_price = Integer.valueOf(receiverMap.get("total_goods_price"));
		int goods_delivery_price = Integer.parseInt(receiverMap.get("goods_delivery_price"));
		int final_total_price = total_goods_price + goods_delivery_price;
		for(int i=0; i<myOrderList.size();i++){
			orderVO=(OrderVO)myOrderList.get(i);
			orderVO.setOrder_id(order_id);	
			orderVO.setMember_id(member_id);
			orderVO.setRecipient_hp(recipient_hp);
			orderVO.setRecipient_tel(recipient_tel);
			orderVO.setDeliveryAddr(deliveryAddr);
			orderVO.setDeliveryMessage(receiverMap.get("deliveryMessage"));
			orderVO.setPayment_method(receiverMap.get("pay_method"));
			orderVO.setCard_com_name(receiverMap.get("card_com_name"));
			orderVO.setTotal_goods_price(total_goods_price);
			orderVO.setOrder_goods_qty(Integer.valueOf(receiverMap.get("order_goods_qty")));
			orderVO.setFinal_total_price(final_total_price);
			myOrderList.set(i, orderVO); 
		}//end for
		orderService.addNewOrder(myOrderList);
		 ModelAndView mav = new ModelAndView("/goods/orderResult");
		 GoodsVO goodsVO = (GoodsVO)session.getAttribute("goods");
		 mav.addObject("total_goods_price", total_goods_price);
		 mav.addObject("goods", goodsVO);
		mav.addObject("myOrderList", myOrderList);
		session.removeAttribute("orderInfo");
		session.removeAttribute("goods");
		return mav;
	}
	

}
