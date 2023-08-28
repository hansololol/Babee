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
import com.babee.community.vo.InfoVO;
import com.babee.community.vo.QnaVO;
import com.babee.member.vo.MemberVO;




@Controller("communityController")
@RequestMapping(value="/community")
public class CommunityControllerImpl extends BaseController implements CommunityController{
	private static String CURR_IMAGE_REPO_PATH_FREEBOARD = "c:/shopping/community/freeboard";
	private static String CURR_IMAGE_REPO_PATH_INFO = "c:/shopping/community/info";
	@Autowired
	private CommunityService communityService;
	@Autowired
	private FreeboardVO freeboardVO;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private CommentVO commentVO;
	@Autowired
	private QnaVO qnaVO;
	@Autowired
	private InfoVO infoVO;
	
	
	
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
		String member_id = memberVO.getMember_id();

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
			 // int articleNO = freeboard.getArticleNO();
			  
			  int articleNO = (int) freeboardMap.get("articleNO");
			  System.out.println("아티클넘: " + articleNO);
		  if(imageFileName !=null && imageFileName.size() !=0) { 
			  File srcFile = new File(CURR_IMAGE_REPO_PATH_FREEBOARD + "\\" + "temp" + "\\" + imageFileName.get(0)); 
			  File destDir = new File(CURR_IMAGE_REPO_PATH_FREEBOARD+ "\\" + member_id + "\\" + articleNO );
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
	
	
	@Override
	@RequestMapping(value = "/removeFreeboard.do", method = RequestMethod.POST)
	public ModelAndView removeFreeboard(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String articleNO = request.getParameter("articleNO");
		String free_img_id = request.getParameter("free_img_id");
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		Map freeboardMap = new HashMap<>();
		freeboardMap.put("member_id", member_id);
		freeboardMap.put("articleNO", articleNO);
		freeboardMap.put("free_img_id", free_img_id);
		communityService.delFreeboard(freeboardMap);
		
		
		if(articleNO!=null) {
			File delFolder = new File(CURR_IMAGE_REPO_PATH_FREEBOARD+ "\\" + member_id + "\\" +articleNO );
			File[] deleteFolderList = delFolder.listFiles();
			
			for (int j = 0; j < deleteFolderList.length; j++  ) {
				System.out.println(deleteFolderList[j]);
				deleteFolderList[j].delete();
			}
			delFolder.delete();
		}
		
		ModelAndView mav = new ModelAndView("redirect:/community/freeboardList.do");
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
	
	
	
	@Override
	@RequestMapping(value="/addqna.do" ,method = RequestMethod.POST)
	public ModelAndView addqna(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		System.out.println("아이디: " + member_id);
		String qna_title = request.getParameter("qna_title");
		String qna_content = request.getParameter("qna_content"); 
		
		QnaVO qnaVO = new QnaVO();
		qnaVO.setMember_id(member_id);
		qnaVO.setQna_title(qna_title);
		qnaVO.setQna_content(qna_content);
		
		System.out.println("vo:" + qnaVO.getQna_title());
		
		communityService.addQan(qnaVO);
		
		
		mav.setViewName("redirect:/community/questionList.do");
		return mav;
		
	}
	
	
	@Override
	@RequestMapping(value="/questionList.do" ,method = RequestMethod.GET)
	public ModelAndView myqnaList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		System.out.println("myqnaList.do 실행");
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum"); 
		int section =Integer.parseInt(((_section==null)? "1":_section)); 
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		
		
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		
		List qnaList = new ArrayList<>();
		qnaList = communityService.selectMyQnaList(member_id);
		int ListSize = qnaList.size();
		mav.addObject("qnaList", qnaList);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("totArticles", ListSize);
		
		return mav;
	}
	
	
	
	
	@Override
	@RequestMapping(value="/addInfo.do", method = RequestMethod.POST)
	public ModelAndView addInfo(@ModelAttribute("infoVO") InfoVO info, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		System.out.println("/addInfo.do 실행");
		multipartRequest.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		System.out.println("작성자 아이디: " + member_id );
		

		Map<String, Object> InfoMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name=(String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
			InfoMap.put(name, value);		
		}
		List imageFileName = upload2(multipartRequest);
		
		InfoMap.put("info_img", imageFileName.get(0));
		int info_img_id_ = (int) Math.floor(Math.random()*1000000);
		String info_img_id = String.valueOf(info_img_id_);
		InfoMap.put("info_img_id", info_img_id);
		InfoMap.put("member_id", member_id);
		
		  try {
			  communityService.addInfo(InfoMap);   
			  int articleNO = (int) InfoMap.get("articleNO");
			  System.out.println("아티클넘: " + articleNO);
		  if(imageFileName !=null && imageFileName.size() !=0) { 
			  File srcFile = new File(CURR_IMAGE_REPO_PATH_INFO + "\\" + "temp" + "\\" + imageFileName.get(0)); 
			  File destDir = new File(CURR_IMAGE_REPO_PATH_INFO+ "\\" + member_id + "\\" + articleNO );
			  FileUtils.moveFileToDirectory(srcFile, destDir, true); 
		  
	
		
		  mav.setViewName("redirect:/community/admininfolist.do");
		  }
		  }catch (Exception e) {
			  e.printStackTrace();
	    	}
		
		
		return mav;
	}
	
	
	@Override
	@RequestMapping(value="/admininfolist.do" ,method = RequestMethod.GET)
	public ModelAndView infoboardList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		System.out.println("admininfolist.do 실행");
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum"); 
		int section =Integer.parseInt(((_section==null)? "1":_section)); 
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		 
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		List myInfoboard =communityService.selectInfoboard(memberVO.getMember_id());
		System.out.println("myInfoboard: " + myInfoboard);
		List infoboard = new ArrayList<>();
		int ListSize = myInfoboard.size();
		for(int i =(pageNum-1)*10; i <pageNum*10;i++) {
			try {
				infoVO = (InfoVO) myInfoboard.get(i);
				infoboard.add(infoVO);
			}catch(IndexOutOfBoundsException e) {
				break;
			}
			}
		 	mav.addObject("infoboard", infoboard);
			mav.addObject("section", section);
			mav.addObject("pageNum", pageNum);
			mav.addObject("totArticles", ListSize);
		return mav;
	}
	
	@Override
	@RequestMapping(value = "/admininfoDetail.do", method = { RequestMethod.POST, RequestMethod.GET} )
	public ModelAndView admininfoDetail(@RequestParam("articleNO") String articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/admininfoDetail.do 실행");
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		session.setAttribute("articleNO", articleNO);
		
		Map infoboardMap = communityService.admininfoDetail(articleNO);
		ModelAndView mav = new ModelAndView(viewName);
		InfoVO infoVO = (InfoVO) infoboardMap.get("infoVO");
		System.out.println("ㅇㅇ"+infoVO.getInfo_content());
		
		mav.addObject("infoboard", infoVO);
		
		

		return mav;

	}
	
	@Override
	@RequestMapping(value="/infoList.do" , method = { RequestMethod.POST, RequestMethod.GET} )
	public ModelAndView infoList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		System.out.println("infoList.do 실행");
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum"); 
		int section =Integer.parseInt(((_section==null)? "1":_section)); 
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		 
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		List myInfoboard =communityService.selectAllinfo();
		System.out.println("myInfoboard: " + myInfoboard);
		List infoboard = new ArrayList<>();
		int ListSize = myInfoboard.size();
		for(int i =(pageNum-1)*10; i <pageNum*10;i++) {
			try {
				infoVO = (InfoVO) myInfoboard.get(i);
				infoboard.add(infoVO);
			}catch(IndexOutOfBoundsException e) {
				break;
			}
			}
		 	mav.addObject("infoboard", infoboard);
			mav.addObject("section", section);
			mav.addObject("pageNum", pageNum);
			mav.addObject("totArticles", ListSize);
		return mav;
	}
	
	
	
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
	
	protected List upload2(MultipartHttpServletRequest multipartRequest) throws Exception{
		List imageFileName = new ArrayList();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String imgfname = mFile.getOriginalFilename();
			imageFileName.add(imgfname);
			File file = new File(CURR_IMAGE_REPO_PATH_INFO+ "\\" + "temp" + "\\" + fileName);
			if(mFile.getSize()!=0) {
				if(!file.exists()) {
				file.getParentFile().mkdirs();
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH_INFO+ "\\" + "temp" + "\\" + imgfname));
				}
			}
		}
		return imageFileName;
	}

}
