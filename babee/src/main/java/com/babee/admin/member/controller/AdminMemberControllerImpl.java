package com.babee.admin.member.controller;


import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.admin.member.service.AdminMemberService;
import com.babee.common.base.BaseController;
import com.babee.diary.vo.DiaryVO;
import com.babee.goods.vo.GoodsQNA;
import com.babee.goods.vo.GoodsVO;
import com.babee.member.vo.MemberVO;
import com.babee.mypage.vo.ReviewVO;
import com.babee.seller.vo.SellerVO;

@Controller("adminMemberController")
@RequestMapping(value="/admin/member")
public class AdminMemberControllerImpl extends BaseController  implements AdminMemberController{
	private static String ARTICLE_IMAGE_REPO = "c:/shopping/file_repo";
	@Autowired
	private AdminMemberService adminMemberService;
	@Autowired
	private SellerVO sellerVO;
	@Autowired
	private MemberVO memberVO;
	
	@RequestMapping(value="/adminMemberMain.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,
			                           HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		String search_type = dateMap.get("search_type");
		String search_word = dateMap.get("search_word");
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		System.out.println(beginDate + "~" + endDate + "시작 끝 날짜 확인" );
		
		HashMap<String,Object> condMap=new HashMap<String,Object>();
		if(section== null) {
			section = "1";
		}
		condMap.put("section",section);
		if(pageNum== null) {
			pageNum = "1";
		}
		condMap.put("pageNum",pageNum);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		condMap.put("search_type", search_type);
		condMap.put("search_word", search_word);
		ArrayList<MemberVO> member_list=adminMemberService.listMember(condMap);
		mav.addObject("member_list", member_list);
		
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate2[0]);
		mav.addObject("endMonth",endDate2[1]);
		mav.addObject("endDay",endDate2[2]);
		
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		return mav;
		
	}
	@RequestMapping(value="/memberDetail.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView memberDetail(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String member_id=request.getParameter("member_id");
		MemberVO member_info=adminMemberService.memberDetail(member_id);
		System.out.println(member_info.getMember_id() + "멤버인포 정보 안넘어옴..");
		mav.addObject("member_info",member_info);
		return mav;
	}
	
	@RequestMapping(value="/modifyMemberInfo.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public void modifyMemberInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HashMap<String,String> memberMap=new HashMap<String,String>();
		String val[]=null;
		PrintWriter pw=response.getWriter();
		String member_id=request.getParameter("member_id");
		String mod_type=request.getParameter("mod_type");
		String value =request.getParameter("value");
		if(mod_type.equals("member_birth")){
			val=value.split(",");
			memberMap.put("member_birth_y",val[0]);
			memberMap.put("member_birth_m",val[1]);
			memberMap.put("member_birth_d",val[2]);
			memberMap.put("member_birth_gn",val[3]);
		}else if(mod_type.equals("tel")){
			val=value.split(",");
			memberMap.put("tel1",val[0]);
			memberMap.put("tel2",val[1]);
			memberMap.put("tel3",val[2]);
			
		}else if(mod_type.equals("hp")){
			val=value.split(",");
			memberMap.put("hp1",val[0]);
			memberMap.put("hp2",val[1]);
			memberMap.put("hp3",val[2]);
			memberMap.put("smssts_yn", val[3]);
		}else if(mod_type.equals("email")){
			val=value.split(",");
			memberMap.put("email1",val[0]);
			memberMap.put("email2",val[1]);
			memberMap.put("emailsts_yn", val[2]);
		}else if(mod_type.equals("address")){
			val=value.split(",");
			memberMap.put("zipcode",val[0]);
			memberMap.put("roadAddress",val[1]);
			memberMap.put("jibunAddress", val[2]);
			memberMap.put("namujiAddress", val[3]);
		}
		
		memberMap.put("member_id", member_id);
		
		adminMemberService.modifyMemberInfo(memberMap);
		pw.print("mod_success");
		pw.close();		
		
	}
	
	@RequestMapping(value="/deleteMember.do" ,method={RequestMethod.POST})
	public ModelAndView deleteMember(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		HashMap<String,String> memberMap=new HashMap<String,String>();
		String member_id=request.getParameter("member_id");
		String del_yn=request.getParameter("del_yn");
		memberMap.put("del_yn", del_yn);
		memberMap.put("member_id", member_id);
		
		adminMemberService.modifyMemberInfo(memberMap);
		mav.setViewName("redirect:/admin/member/adminMemberMain.do");
		return mav;
		
	}
	
	//----------------------------사업자 관리----------------------------------------
	@Override
	@RequestMapping(value="/sellerManageList.do" , method= RequestMethod.GET)
	public ModelAndView sellerManageList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		
		ModelAndView mav = new ModelAndView("/admin/member/sellerManageList");
		HttpSession session=request.getSession();
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum"); 
		int section =Integer.parseInt(((_section==null)? "1":_section)); 
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		 
		memberVO = (MemberVO) session.getAttribute("memberInfo");
	
		
		Map sellerMap = new HashMap();
		int start = ((section-1)*5+(pageNum-1))*10; 
		sellerMap.put("start", start);
		
		List seller =adminMemberService.sellerManageList(sellerMap);
		int ListSize = seller.size();
		
		mav.addObject("seller", seller);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("totArticles", ListSize);
		
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/sellerDetail.do" ,method = RequestMethod.GET)
	public ModelAndView sellerDetail(@RequestParam("seller_id") String seller_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("sellerDetail.do 실행");
		ModelAndView mav = new ModelAndView("/admin/member/sellerDetail");
		Map sellerMap=adminMemberService.sellerDetail(seller_id);
		
		SellerVO sellerVO = (SellerVO)sellerMap.get("sellerVO");
		mav.addObject("seller", sellerVO);
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/sellerManageWait.do" , method= RequestMethod.GET)
	public ModelAndView sellerManageWait(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView("/admin/member/sellerManageWait");
		HttpSession session=request.getSession();
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum"); 
		int section =Integer.parseInt(((_section==null)? "1":_section)); 
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		 
		memberVO = (MemberVO) session.getAttribute("memberInfo");
	
		
		Map sellerMap = new HashMap();
		int start = ((section-1)*5+(pageNum-1))*10; 
		sellerMap.put("start", start);
		
		List seller =adminMemberService.sellerManageWait(sellerMap);
		int ListSize = seller.size();
		
		mav.addObject("seller", seller);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("totArticles", ListSize);
		
		
		return mav;
	}
	@Override
	@RequestMapping(value="/sellerWaitDetail.do" ,method = RequestMethod.GET)
	public ModelAndView sellerWaitDetail(@RequestParam("seller_id") String seller_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("sellerWaitDetail.do 실행");
		ModelAndView mav = new ModelAndView("/admin/member/sellerWaitDetail");
		Map sellerMap=adminMemberService.sellerWaitDetail(seller_id);
		
		SellerVO sellerVO = (SellerVO)sellerMap.get("sellerVO");
		mav.addObject("seller", sellerVO);
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/sellerRegister.do", method = RequestMethod.POST)
	public ModelAndView sellerRegister(HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("sellerRegister.do 실행");
		String seller_id = request.getParameter("seller_id");
		String seller_status = request.getParameter("seller_status");
		System.out.println(seller_id);
		System.out.println(seller_status);
		HttpSession session=request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		Map<String, Object> sellerMap = new HashMap<String, Object>();
		sellerMap.put("seller_id", seller_id);
		sellerMap.put("seller_status", seller_status);
		adminMemberService.sellerRegister(sellerMap);
		System.out.println(sellerMap);
		
		ModelAndView mav = new ModelAndView("redirect:/admin/member/sellerManageWait.do");
		  
		return mav;
	}
	
	@Override
	@RequestMapping(value="/sellerRefuse.do", method = RequestMethod.POST)
	public ModelAndView sellerRefuse(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String seller_id = request.getParameter("seller_id");
		String seller_status = request.getParameter("seller_status");
		String seller_refuse = request.getParameter("seller_refuse");
		HttpSession session=request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		Map<String, Object> sellerMap = new HashMap<String, Object>();
		sellerMap.put("seller_id", seller_id);
		sellerMap.put("seller_status", seller_status);
		sellerMap.put("seller_refuse", seller_refuse);
		adminMemberService.sellerRefuse(sellerMap);
		
		ModelAndView mav = new ModelAndView("redirect:/admin/member/sellerManageWait.do");
		  
		return mav;
	}
	
	@Override
	@RequestMapping(value = "/removeSeller.do", method = RequestMethod.POST)
	public ModelAndView removeSeller(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		String seller_id = request.getParameter("seller_id");
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		Map sellerMap = new HashMap<>();
		sellerMap.put("seller_id", seller_id);
		adminMemberService.removeSeller(sellerMap);
		
		if(seller_id!=null) {
			File delFolder = new File(ARTICLE_IMAGE_REPO+ "\\" + seller_id);
			File[] deleteFolderList = delFolder.listFiles();
			
			for (int j = 0; j < deleteFolderList.length; j++  ) {
				System.out.println(deleteFolderList[j]);
				deleteFolderList[j].delete();
			}
			delFolder.delete();
		}
		
		PrintWriter out = response.getWriter();
		out.println("<script>alert('삭제 완료되었습니다.');location.href='/admin/member/sellerManageList.do'</script>");
		out.flush();
		out.close();
		
	
		return null;
		
	}
	
	//-------------------회원 관리--------------------------
	@Override
	@RequestMapping(value="/memberManageList.do" , method= RequestMethod.GET)
	public ModelAndView memberManageList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		System.out.println("memberManageList.do 실행");
		ModelAndView mav = new ModelAndView("/admin/member/memberManageList");
		HttpSession session=request.getSession();
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum"); 
		int section =Integer.parseInt(((_section==null)? "1":_section)); 
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		 
		memberVO = (MemberVO) session.getAttribute("memberInfo");
	
		
		Map memberMap = new HashMap();
		int start = ((section-1)*5+(pageNum-1))*10; 
		memberMap.put("start", start);
		
		List member =adminMemberService.memberManageList(memberMap);
		int ListSize = member.size();
		
		mav.addObject("member", member);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("totArticles", ListSize);
		
		return mav;
		
	}
	
	@Override
	@RequestMapping(value="/memberManageDetail.do" ,method = RequestMethod.GET)
	public ModelAndView memberManageDetail(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("memberManageDetail.do 실행");
		ModelAndView mav = new ModelAndView("/admin/member/memberManageDetail");
		Map memberMap=adminMemberService.memberManageDetail(member_id);
		
		MemberVO memberVO = (MemberVO)memberMap.get("memberVO");
		mav.addObject("member", memberVO);
		
		return mav;
		
	}
	
}
