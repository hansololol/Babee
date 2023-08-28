package com.babee.seller.controller;

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
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;
import com.babee.seller.service.SellerService;
import com.babee.seller.vo.SellerVO;


@Controller("sellerController")
@RequestMapping(value="/seller")
public class SellerControllerImpl extends BaseController implements SellerController{
	private static String ARTICLE_IMAGE_REPO = "c:/shopping/file_repo";
	@Autowired
	private SellerService sellerService;
	@Autowired
	private SellerVO sellerVO;
	private static final String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
	
	
	@Override
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public ModelAndView login(Map<String, String> loginMap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@RequestMapping(value="/logout.do" ,method = RequestMethod.POST)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@RequestMapping(value="/addSeller.do" ,method = RequestMethod.POST)
	public ResponseEntity addSeller(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> studentMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name=(String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
			
			studentMap.put(name, value);		
		}
		List imageFileName = upload(multipartRequest);
	
		String seller_id = multipartRequest.getParameter("seller_id");
			
			studentMap.put("seller_img1", imageFileName.get(0));	
		
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
		
		   sellerService.addMember(studentMap);
		   if(imageFileName !=null && imageFileName.size() !=0) {
				 File srcFile = new File(ARTICLE_IMAGE_REPO+ "\\" + "temp" + "\\" + imageFileName.get(0));
				 File destDir = new File(ARTICLE_IMAGE_REPO+ "\\" + seller_id);
				 FileUtils.moveFileToDirectory(srcFile, destDir, true);
			 }
		    message  = "<script>";
		    message +=" alert('회원가입에 성공하였습니다.');";
		    message += " location.href='"+multipartRequest.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('회원 가입에 실패하였습니다. 다시 입력해주세요');";
		    message += " location.href='"+multipartRequest.getContextPath()+"/seller/sellerForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	//업데이트
	@Override
	@RequestMapping(value="/modgoods.do", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView modGoods(@RequestParam("goods_id") int goods_id, @RequestParam Map<String, Object> modGoodsMap,
            MultipartHttpServletRequest multipartRequest,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		GoodsVO goodsVO = new GoodsVO();
		//Map<String, Object> modGoodsMap = new HashMap<String, Object>();
		HttpSession session = multipartRequest.getSession();
		
		SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		String seller_id = sellerVO.getSeller_id();
		modGoodsMap.put("seller_id", seller_id);
		
		Map<String, Object> goodsInfo = sellerService.getGoodsInfo(goods_id);
	   
		System.out.println("구우우우우웅ㅅ!: "+goods_id);
		
		
		System.out.println("modGoodsMap의 모든 값:");
		for (Map.Entry<String, Object> entry : goodsInfo.entrySet()) {
		    //modGoodsMap.put(entry.getKey(), entry.getValue());
		    System.out.println("modmodmodmodmo: " + entry.getKey() + ": " + entry.getValue());
		}
	    
	    modGoodsMap.put("image_id", goodsInfo.get("goods_image_name1_id"));
	    System.out.println("아라라라ㅏ라라ㅏ라라ㅏ랄");
	    System.out.println(goodsInfo.get("goods_image_name1_id"));
		// 이미지1 처리
	       List<MultipartFile> image1FileList = multipartRequest.getFiles("goods_image_name1");
	       for (MultipartFile file : image1FileList) {
	           String fileName = file.getOriginalFilename();
	           System.out.println("name1:" + fileName);
	           goodsVO.setGoods_image_name1(fileName);
	           // 이미지1 처리 로직
	           ImageFileVO imageFileVO = new ImageFileVO();
	           imageFileVO.setFileName(fileName);
	           modGoodsMap.put("goods_image_name1", fileName);
	           modGoodsMap.put("fileName", fileName);
	       }
	    // 이미지2 처리
	       List<MultipartFile> image2FileList = multipartRequest.getFiles("goods_image_name2");
	       for (MultipartFile file : image2FileList) {
	           String fileName = file.getOriginalFilename();
	           System.out.println("name2:" + fileName);
	           goodsVO.setGoods_image_name2(fileName);
	           // 이미지2 처리 로직
	           ImageFileVO imageFileVO = new ImageFileVO();
	           imageFileVO.setFileName(fileName);
	           modGoodsMap.put("goods_image_name2", fileName);
	           modGoodsMap.put("detailFile", fileName);
	       }
	       System.out.println("이미지 파일네임!!!!!!!");
	       System.out.println(modGoodsMap.get("fileName"));
	       System.out.println(modGoodsMap.get("detailFile"));
	       
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name=(String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
			modGoodsMap.put(name, value);
			System.out.println("enu출력1111 "+name+":"+ value);
		}
		
		List<String> imageFileName = upload(multipartRequest);
	    
		  sellerService.updateGoods(modGoodsMap);
		  sellerService.updateGoodsImage(modGoodsMap);
		  System.out.println("컨트롤러 이미지파일네임!! "+ imageFileName);
		
		  try {
			  
			  if (imageFileName != null && !imageFileName.isEmpty()) {
				    for (String fileName : imageFileName) {
				        File srcFile = new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + fileName);
				        File destDir = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id);
				        
				        System.out.println("파아아아아알일 " + fileName);
				        
				        // 이미지 파일을 옮깁니다.
				        FileUtils.moveFileToDirectory(srcFile, destDir, true);
				    }
				    
				    // 이미지 파일을 옮긴 후 기존 파일 삭제
				    String goods_image_name1 = (String) goodsInfo.get("goods_image_name1");
				    if (goods_image_name1 != null && !goods_image_name1.isEmpty()) {
				        File oldFile1 = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id + "\\" + goods_image_name1);
				        oldFile1.delete();
				        System.out.println("기존 파일 1 삭제: " + oldFile1.getPath());
				    }

				    String goods_image_name2 = (String) goodsInfo.get("goods_image_name2");
				    if (goods_image_name2 != null && !goods_image_name2.isEmpty()) {
				        File oldFile2 = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id + "\\" + goods_image_name2);
				        oldFile2.delete();
				        System.out.println("기존 파일 2 삭제: " + oldFile2.getPath());
				    }
				}
		  mav.setViewName("redirect:/seller/listSellerGoods.do?page=sellerPage");
		  
		  }catch (Exception e) {
			  e.printStackTrace();
	    	}
		return mav;
	}
	
	//업데이트 전 값 불러오기
	   @Override
	   @RequestMapping(value = "/modGoodsForm.do", method = RequestMethod.GET)
	   public ModelAndView getGoodsInfo(@RequestParam("goods_id") int goods_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		    ModelAndView mav = new ModelAndView("/seller/modGoodsForm");
		    
		    Map<String, Object> goodsIdMap = new HashMap<String, Object>();
		    goodsIdMap.put("goods_id", goods_id);
		    
		    Map<String, Object> goodsInfo = sellerService.getGoodsInfo(goods_id);
		    
		    mav.addObject("goodsInfo", goodsInfo);
		    //mav.setViewName("/seller/goodsModifyForm");
		    
		    return mav;
	   }
	
	
	@Override
	   @RequestMapping(value = "/removeGoodsImage.do", method={RequestMethod.GET, RequestMethod.POST})
	   public void removeGoodsImage(@RequestParam("goods_id") int goods_id,
			   						@RequestParam("goods_image_name1_id") int goods_image_name1_id,
	                                HttpServletRequest request, HttpServletResponse response) throws Exception {
	       System.out.println("삭제 굿 아이디: " + goods_id);
	       
	       try {
	          sellerService.removeGoodsImage(goods_id);
	          sellerService.removeGoodsImage2(goods_image_name1_id);
	          
	           // 폴더 삭제
	           File srcFolder = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id);
	           deleteDirectory(srcFolder);

	           response.sendRedirect(request.getContextPath() + "/seller/listSellerGoods.do");
	       } catch (Exception e) {
	           e.printStackTrace();
	       }
	   }

	   private void deleteDirectory(File dir) {
	       File[] files = dir.listFiles();
	       if (files != null) {
	           for (File file : files) {
	               if (file.isDirectory()) {
	                   deleteDirectory(file);
	               } else {
	                   file.delete();
	               }
	           }
	       }
	       dir.delete();
	   }
	   
	   @RequestMapping(value="/listSellerGoods.do", method={RequestMethod.POST,RequestMethod.GET})
	   public ModelAndView goodsList(HttpServletRequest request, HttpServletResponse response) throws Exception {
	       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");

	       // 사용자의 로그인 정보를 어떻게 가져올지에 따라 sellerId 변수를 설정
	       HttpSession session = request.getSession();
	      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	      String seller_id = sellerVO.getSeller_id();
	      System.out.println("셀러아이디 사업자: "+ seller_id);
	       List<GoodsVO> sellerGoodsList = sellerService.adminGoodsList(seller_id);
	       
	       mav.addObject("sellerGoodsList", sellerGoodsList);
	       System.out.println("사업자 상품리스트"+ sellerGoodsList);
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
			File file = new File(ARTICLE_IMAGE_REPO+ "\\" + "temp" + "\\" + fileName);
			if(mFile.getSize()!=0) {
				if(!file.exists()) {
				file.getParentFile().mkdirs();
				mFile.transferTo(new File(ARTICLE_IMAGE_REPO+ "\\" + "temp" + "\\" + imgfname));
				}
			}
		}
		return imageFileName;
	}


}
