package com.babee.cart.controller;


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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.babee.cart.service.CartService;
import com.babee.cart.vo.CartVO;
import com.babee.common.base.BaseController;
import com.babee.member.vo.MemberVO;
import com.babee.order.vo.OrderVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	@Autowired
	private CartService cartService;
	@Autowired
	private CartVO cartVO;
	@Autowired
	private MemberVO memberVO;
	
	//@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();
		cartVO.setMember_id(member_id);
		Map<String ,List> cartMap=cartService.myCartList(cartVO);
		session.setAttribute("cartMap", cartMap); 
		//mav.addObject("cartMap", cartMap);
		return mav;
	}
	
	
	@RequestMapping(value="/addGoodsInCart.do" , method=RequestMethod.POST)
	public @ResponseBody ModelAndView addGoodsInCart(@ModelAttribute("cartVO") CartVO cartVO, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String viewName=(String)request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		cartVO.setMember_id(memberVO.getMember_id());
		

		Boolean isAreadyExisted=cartService.findCartGoods(cartVO);

		System.out.println("상품 아이디 " + cartVO.getGoods_id() );
		System.out.println("상품 옵션 " + cartVO.getGoods_option() );
		System.out.println("상품 수량 " + cartVO.getCart_goods_qty() );
		boolean isAreadyExisted=cartService.findCartGoods(cartVO);


		System.out.println("isAreadyExisted:"+isAreadyExisted);
		if(isAreadyExisted==true){
			mav.addObject("result", "already_existed" );
			return mav;
		}else{
			cartService.addGoodsInCart(cartVO);
			mav.addObject("result", "add_success");
			return mav;
		}
		
	}
	
	
	
	
/*	@RequestMapping(value="/addGoodsInCart.do" ,method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public  @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id, @RequestParam("cart_goods_qty") String cart_goods_qty1,
            HttpServletRequest request, HttpServletResponse response)  throws Exception{
			HttpSession session=request.getSession();
				memberVO=(MemberVO)session.getAttribute("memberInfo");
				String member_id=memberVO.getMember_id();
				
				int cart_goods_qty = Integer.parseInt(cart_goods_qty1); 
				cartVO.setMember_id(member_id);

				cartVO.setGoods_id(goods_id);
				cartVO.setMember_id(member_id);
				cartVO.setGoods_option(member_id);
				cartVO.setCart_goods_qty(cart_goods_qty);
				
				
				
//				boolean isAreadyExisted=cartService.findCartGoods(cartVO);
				String isAreadyExisted=cartService.findCartGoods(cartVO);
				//boolean isAreadyExisted =false;
				System.out.println("isAreadyExisted:"+isAreadyExisted);
				if(isAreadyExisted=="true"){
					return "already_existed";
				}else{
					cartService.addGoodsInCart(cartVO);
					return "add_success";
				}
				
			
	}*/
	
	/*@RequestMapping(value = "/addGoodsInCart.do", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public ModelAndView addGoodsInCart(@RequestParam("goods_id") int goods_id,
	        HttpServletRequest request, HttpServletResponse response) throws Exception {
	    HttpSession session = request.getSession();
	    memberVO = (MemberVO) session.getAttribute("memberInfo");
	    String member_id = memberVO.getMember_id();
	    
	    
	    cartVO.setMember_id(member_id);
	    cartVO.setGoods_id(goods_id);
	    cartVO.setMember_id(member_id);
	    System.out.println(goods_id + "  여기");
	    
	    boolean isAreadyExisted = cartService.findCartGoods(cartVO);
	    System.out.println("isAreadyExisted: " + isAreadyExisted);

	    if (isAreadyExisted) {
	        return new ModelAndView(new RedirectView("/cart/myCartList.do"));
	    } else {
	        cartService.addGoodsInCart(cartVO);
	        return new ModelAndView(new RedirectView("/cart/myCartList.do"));
	    }
	}*/
	
	
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
