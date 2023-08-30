package com.babee.cart.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.babee.cart.service.CartService;
import com.babee.cart.vo.CartVO;
import com.babee.common.base.BaseController;
import com.babee.goods.service.GoodsService;
import com.babee.goods.vo.GoodsVO;
import com.babee.member.vo.MemberVO;
import com.babee.seller.vo.SellerVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	@Autowired
	private CartService cartService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private CartVO cartVO;
	@Autowired
	private MemberVO memberVO;

	
	
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		
		System.out.println("myCartMain 메소드 진입");
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		
		HttpSession session = request.getSession();
		String userType = (String) session.getAttribute("userType");
		System.out.println("userType : " + userType);
		
		// 로그인한 사용자 ID 가져오기(memberId)
		List<CartVO> myCartList = null;
		List<GoodsVO> allGoodsList = new ArrayList<>();
		if(userType.equals("M")) {
			MemberVO memberVO = (MemberVO)session.getAttribute("memberInfo");
			String memberId = memberVO.getMember_id();
			
			System.out.println("memberId : " + memberId);
			
			myCartList = cartService.myCartList(memberId);
			
			for(int i=0; i<myCartList.size(); i++) {
				cartVO = myCartList.get(i);
				int goods_id = cartVO.getGoods_id();
				String id= String.valueOf(goods_id);
				Map goods = goodsService.goodsDetail(id);
				GoodsVO goodsCart = (GoodsVO) goods.get("goodsVO");
				cartVO.setCart_image_name(goodsCart.getGoods_image_name1());
				allGoodsList = cartService.selectGoodsList(goods_id);
				allGoodsList.addAll(allGoodsList);
				
				
			}
			System.out.println("myCartList : " + myCartList);
			
			
			
		}else if(userType.equals("S")) {
			SellerVO sellerVO = (SellerVO)session.getAttribute("memberInfo");
			String memberId = sellerVO.getSeller_id();
			
			System.out.println("memberId : " + memberId);
			
			myCartList = cartService.myCartList(memberId);
			
			
			for(int i=0; i<myCartList.size(); i++) {
				cartVO = myCartList.get(i);
				int goods_id = cartVO.getGoods_id();
				String id= String.valueOf(goods_id);
				Map goods = goodsService.goodsDetail(id);
				GoodsVO goodsCart = (GoodsVO) goods.get("goodsVO");
				cartVO.setCart_image_name(goodsCart.getGoods_image_name1());
				allGoodsList = cartService.selectGoodsList(goods_id);
				allGoodsList.addAll(allGoodsList);
			}
			
		}
		
		
		mav.addObject("myCartList", myCartList);
		mav.addObject("goodsList", allGoodsList);

		
		return mav;
	}
	
	
	@PostMapping("addGoodsInCart")
	@ResponseBody
	public String addGoodsInCart(@RequestBody CartVO cartVO, HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("addGoodsInCart 메소드 진입");
		
		boolean isAreadyExisted = cartService.findCartGoods(cartVO);
		
		if(isAreadyExisted==true){
			return "already_existed";
			
		}else{
			cartService.addGoodsInCart(cartVO);
			return "add_success";
		}
	}
	
	
	
	
	
	@RequestMapping(value="/modifyCartQty.do" ,method = RequestMethod.POST)
	public @ResponseBody String  modifyCartQty(@RequestParam("goods_id") int goods_id,
			                                   @RequestParam("cart_goods_qty") String cart_goods_qty,
			                                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();
		cartVO.setGoods_id(goods_id);
		cartVO.setMember_id(member_id);
		//cartVO.setCart_goods_qty(cart_goods_qty);
		boolean result=cartService.modifyCartQty(cartVO);
		
		if(result==true){
		   return "modify_success";
		}else{
			  return "modify_failed";	
		}
		
	}
	
	
	
	
	
	@RequestMapping(value="/removeCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartGoods(@RequestParam("cart_id") int cart_id,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartGoods(cart_id);
		mav.setViewName("redirect:/cart/myCartList.do");
		return mav;
	}
}
