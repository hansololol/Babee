package com.babee.diary.controller;

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
import com.babee.diary.service.DiaryService;
import com.babee.diary.vo.DiaryVO;
import com.babee.goods.vo.GoodsVO;
import com.babee.member.vo.MemberVO;
import com.babee.mypage.vo.ReviewVO;




@Controller("diaryController")
@RequestMapping(value="/diary")
public class DiaryControllerImpl extends BaseController implements DiaryController{
	private static String CURR_IMAGE_REPO_PATH_DIARY = "c:/shopping/diary";
	@Autowired
	private DiaryService diaryService;
	@Autowired
	private DiaryVO diaryVO;
	@Autowired
	private MemberVO memberVO;
	
	@Override
	@RequestMapping(value="/diaryList.do" ,method = RequestMethod.GET)
	public ModelAndView diaryList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		  String _section = request.getParameter("section"); 
		  String _pageNum = request.getParameter("pageNum"); 
		  int section =Integer.parseInt(((_section==null)? "1":_section)); 
		  int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		 
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		List myDiary =diaryService.selectDiary(memberVO.getMember_id());
		List diary = new ArrayList<>();
		int ListSize = myDiary.size();
		for(int i =(pageNum-1)*10; i <pageNum*10;i++) {
			try {
				diaryVO = (DiaryVO) myDiary.get(i);
				diary.add(diaryVO);
			}catch(IndexOutOfBoundsException e) {
				break;
			}
			}
		 	mav.addObject("diary", diary);
			mav.addObject("section", section);
			mav.addObject("pageNum", pageNum);
			mav.addObject("totArticles", ListSize);
		return mav;
	}

	@Override
	@RequestMapping(value="/addDiary.do", method = RequestMethod.POST)
	public ModelAndView addDiary(@ModelAttribute("diaryVO") DiaryVO diary,
			MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");

		Map<String, Object> diaryMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name=(String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
			diaryMap.put(name, value);		
		}
		List imageFileName = upload(multipartRequest);
		diaryMap.put("dir_main_img", imageFileName.get(0));
		int img_id = (int) Math.floor(Math.random()*1000000);
		String dir_main_img_id = String.valueOf(img_id);
		diaryMap.put("dir_main_img_id", dir_main_img_id);
		
		  try {
		  
			  diaryService.addDiary(diaryMap); 
		  if(imageFileName !=null && imageFileName.size() !=0) { 
			  File srcFile = new File(CURR_IMAGE_REPO_PATH_DIARY + "\\" + "temp" + "\\" + imageFileName.get(0)); 
			  File destDir = new File(CURR_IMAGE_REPO_PATH_DIARY+ "\\" + memberVO.getMember_id());
		  FileUtils.moveFileToDirectory(srcFile, destDir, true); 
		  mav.setViewName("redirect:/diary/diaryList.do");
		  }
		  }catch (Exception e) {
			  e.printStackTrace();
	    	}
		return mav;
	}
	
	@RequestMapping(value="/diaryDetail.do" ,method = RequestMethod.GET)
	public ModelAndView diaryDetail(@RequestParam("dir_no") String dir_no,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		HttpSession session=request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		
		Map diaryMap=diaryService.diaryDetail(dir_no);
		ModelAndView mav = new ModelAndView(viewName);
		DiaryVO diaryVO = (DiaryVO)diaryMap.get("diaryVO");
		mav.addObject("diary", diaryVO);
		
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
			File file = new File(CURR_IMAGE_REPO_PATH_DIARY+ "\\" + "temp" + "\\" + fileName);
			if(mFile.getSize()!=0) {
				if(!file.exists()) {
				file.getParentFile().mkdirs();
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH_DIARY+ "\\" + "temp" + "\\" + imgfname));
				}
			}
		}
		return imageFileName;
	}

}
