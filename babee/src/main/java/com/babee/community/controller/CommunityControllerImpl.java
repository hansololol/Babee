package com.babee.community.controller;

import java.io.File;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
import com.babee.community.service.CommunityService;
import com.babee.community.vo.CommentVO;
import com.babee.community.vo.FreeboardVO;
import com.babee.member.vo.MemberVO;




@Controller("communityController")
@RequestMapping(value="/community")
public class CommunityControllerImpl extends BaseController implements CommunityController{
	private static String CURR_IMAGE_REPO_PATH_FREEBOARD = "c:/shopping/community/freeboard";
	@Autowired
	private CommunityService communityService;
	@Autowired
	private FreeboardVO freeboardVO;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private CommentVO commentVO;
	
	@Override
	@RequestMapping(value="/freeboardList.do" ,method = RequestMethod.GET)
	public ModelAndView freeboardList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		System.out.println("freebaordList.do 실행");
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum"); 
		int section =Integer.parseInt(((_section==null)? "1":_section)); 
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		 
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		List myFreeboard =communityService.selectFreeboard(memberVO.getMember_id());
		System.out.println("myFreeboard: " + myFreeboard);
		List freeboard = new ArrayList<>();
		int ListSize = myFreeboard.size();
		for(int i =(pageNum-1)*10; i <pageNum*10;i++) {
			try {
				freeboardVO = (FreeboardVO) myFreeboard.get(i);
				System.out.println("freeboardVO: " +freeboardVO.getFree_title());
				freeboard.add(freeboardVO);
			}catch(IndexOutOfBoundsException e) {
				break;
			}
			}
		 	mav.addObject("freeboard", freeboard);
			mav.addObject("section", section);
			mav.addObject("pageNum", pageNum);
			mav.addObject("totArticles", ListSize);
		return mav;
	}

	@Override
	@RequestMapping(value="/addFreeboard.do", method = RequestMethod.POST)
	public ModelAndView addFreeboard(@ModelAttribute("freeboardVO") FreeboardVO freeboard, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");

		Map<String, Object> freeboardMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name=(String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
			freeboardMap.put(name, value);		
		}
		List imageFileName = upload(multipartRequest);
		freeboardMap.put("free_img", imageFileName.get(0));
		int img_id = (int) Math.floor(Math.random()*1000000);
		String free_img_id = String.valueOf(img_id);
		freeboardMap.put("free_img_id", free_img_id);
		
		  try {
			  communityService.addFreeboard(freeboardMap); 
		  if(imageFileName !=null && imageFileName.size() !=0) { 
			  File srcFile = new File(CURR_IMAGE_REPO_PATH_FREEBOARD + "\\" + "temp" + "\\" + imageFileName.get(0)); 
			  File destDir = new File(CURR_IMAGE_REPO_PATH_FREEBOARD+ "\\" + memberVO.getMember_id());
		  FileUtils.moveFileToDirectory(srcFile, destDir, true); 
		  mav.setViewName("redirect:/community/freeboardList.do");
		  }
		  }catch (Exception e) {
			  e.printStackTrace();
	    	}
		 
		return mav;
	}
	
	@Override
	@RequestMapping(value = "/freeboardDetail.do", method = RequestMethod.GET)
	public ModelAndView freeboardDetail(@RequestParam("articleNO") String articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/freeboardDetail.do 실행");
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		session.setAttribute("articleNO", articleNO);
		
		Map freeboardMap = communityService.freeboardDetail(articleNO);
		ModelAndView mav = new ModelAndView(viewName);
		FreeboardVO freeboardVO = (FreeboardVO) freeboardMap.get("freeboardVO");
		mav.addObject("freeboard", freeboardVO);
		


		List commentList = communityService.selectComment(articleNO);
		System.out.println("commentList : " + commentList);
		mav.addObject("commentList", commentList);
		
		return mav;

	}
	
	@Override
	@RequestMapping(value = "/addCommnet.do", method = RequestMethod.POST)
	public ModelAndView addComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/addCommnet.do 실행");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		String articleNO_ = (String) session.getAttribute("articleNO");
		int articleNO = Integer.parseInt(articleNO_);
		String free_comment = request.getParameter("free_comment");
		System.out.println("free_comment: " + free_comment);
		
		commentVO.setArticleNO(articleNO);
		commentVO.setFree_comment(free_comment);
		commentVO.setMember_id(member_id);
		communityService.addComment(commentVO);
		
		mav.addObject("articleNO", articleNO);
		mav.setViewName("redirect:/community/freeboardDetail.do");
		return mav;

	}
	  
	  
	/*
	 * @Override
	 * 
	 * @RequestMapping(value="/modDiary.do", method = RequestMethod.POST) public
	 * ModelAndView modDiary(@ModelAttribute("diaryVO") DiaryVO diary,
	 * MultipartHttpServletRequest multipartRequest, HttpServletRequest request,
	 * HttpServletResponse response) throws Exception {
	 * multipartRequest.setCharacterEncoding("utf-8"); ModelAndView mav = new
	 * ModelAndView(); HttpSession session=request.getSession(); memberVO =
	 * (MemberVO) session.getAttribute("memberInfo");
	 * System.out.println("modDiary 들어왔나"); Map<String, Object> diaryMap = new
	 * HashMap<String, Object>(); Enumeration enu =
	 * multipartRequest.getParameterNames(); while(enu.hasMoreElements()) { String
	 * name=(String)enu.nextElement(); String value =
	 * multipartRequest.getParameter(name); diaryMap.put(name, value); } List
	 * imageFileName = upload(multipartRequest); diaryMap.put("dir_main_img",
	 * imageFileName.get(0)); int img_id = (int) Math.floor(Math.random()*1000000);
	 * String dir_main_img_id = String.valueOf(img_id);
	 * diaryMap.put("dir_main_img_id", dir_main_img_id);
	 * 
	 * try { diaryService.modDiary(diaryMap); if(imageFileName !=null &&
	 * imageFileName.size() !=0) { File srcFile = new
	 * File(CURR_IMAGE_REPO_PATH_DIARY + "\\" + "temp" + "\\" +
	 * imageFileName.get(0)); File destDir = new File(CURR_IMAGE_REPO_PATH_DIARY+
	 * "\\" + memberVO.getMember_id()); FileUtils.moveFileToDirectory(srcFile,
	 * destDir, true);
	 * 
	 * String dir_main_img = (String) diaryMap.get("originalFileName"); File oldFile
	 * = new File(CURR_IMAGE_REPO_PATH_DIARY+ "\\" + memberVO.getMember_id() + "\\"
	 * + dir_main_img ); oldFile.delete();
	 * mav.setViewName("redirect:/diary/diaryDetail.do?dir_no="+
	 * diaryVO.getDir_no()); } }catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return mav; }
	 */
	 
	
	protected List upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		List imageFileName = new ArrayList();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String imgfname = mFile.getOriginalFilename();
			imageFileName.add(imgfname);
			File file = new File(CURR_IMAGE_REPO_PATH_FREEBOARD+ "\\" + "temp" + "\\" + fileName);
			if(mFile.getSize()!=0) {
				if(!file.exists()) {
				file.getParentFile().mkdirs();
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH_FREEBOARD+ "\\" + "temp" + "\\" + imgfname));
				}
			}
		}
		return imageFileName;
	}

}
