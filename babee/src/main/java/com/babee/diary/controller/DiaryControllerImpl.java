package com.babee.diary.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
import com.babee.diary.service.DiaryService;
import com.babee.diary.vo.DiaryVO;
import com.babee.member.vo.MemberVO;



@Controller("diaryController")
@RequestMapping(value="/diary")
public class DiaryControllerImpl extends BaseController implements DiaryController{
	private static final String DIARY_IMAGE_REPO = "c:\\shopping\\diary_img";
	@Autowired
	private DiaryService diaryService;
	@Autowired
	private DiaryVO diaryVO;
	@Autowired
	private MemberVO memberVO;
	
	
	@Override
	public ModelAndView diaryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@RequestMapping(value="/diary/addDiary.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity addDiary(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> diaryMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String member_name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(member_name);
			diaryMap.put(member_name, value);
		}
		String member_id = multipartRequest.getParameter("member_id");
		String dir_main_img = diary_img_upload(multipartRequest);
		diaryMap.put("dir_main_img", dir_main_img);
		
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=utf-8");
		try {
			int num = diaryService.addDiary(diaryMap);
			if(dir_main_img!=null&&dir_main_img.length()!=0) {
				File srcFile = new File(DIARY_IMAGE_REPO + "\\" + "temp" + "\\" + dir_main_img);
				File destDir = new File(DIARY_IMAGE_REPO + "\\" + member_id);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				message = "<script>";
				message += " alert('다이어리 작성이 완료되었습니다!');";
				message += " location.href='" + multipartRequest.getContextPath() + "/diary/diaryList.do';";
				message += "</script>";
				resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			}
		} catch(Exception e) {
			File srcFile = new File(DIARY_IMAGE_REPO + "\\" + "temp" + "\\" + dir_main_img);
			srcFile.delete();
			message = "<script>";
			message += " alert('다이어리 작성에 실패하였습니다. 다시 시도하기 바랍니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/diary/diaryForm.do';";
			message += "</script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	private String diary_img_upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		String imageFileName = null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			imageFileName = mFile.getOriginalFilename();
			File file = new File(DIARY_IMAGE_REPO + "\\" + "temp" + "\\" + fileName);
			if(mFile.getSize()!=0) {
				if(!file.exists()) {
					file.getParentFile().mkdirs();
					mFile.transferTo(new File(DIARY_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName));
				}
			}
		}
		return imageFileName;
	}

}
