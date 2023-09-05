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
import com.babee.goods.service.GoodsService;
import com.babee.goods.vo.GoodsQNA;
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
	private GoodsService goodsService;
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
	
	@Override
	@RequestMapping(value="/updateSeller.do" , method= RequestMethod.POST)
	public ModelAndView updateSeller (@ModelAttribute("sellerVO") SellerVO _sellerVO, MultipartHttpServletRequest multipartRequest,HttpServletRequest request, HttpServletResponse response) throws Exception{
		 HttpSession session=request.getSession();
		 session.removeAttribute("memberInfo");
		session.setAttribute("memberInfo",_sellerVO);
		 ModelAndView mav = new ModelAndView();
		List imageFileName = upload(multipartRequest);
		String sellerImage = (String) imageFileName.get(0);
		System.out.println(sellerImage + "사업자 이미지 안옴. ");
		 if (sellerImage != null && !sellerImage.isEmpty()) {
		        File oldFile1 = new File(CURR_IMAGE_REPO_PATH + "\\" + _sellerVO.getSeller_id() + "\\"+sellerImage);
		        oldFile1.delete();
		 }else {
			 File srcFile = new File(ARTICLE_IMAGE_REPO+ "\\" + "temp" + "\\" + sellerImage);
			 File destDir = new File(ARTICLE_IMAGE_REPO+ "\\" + _sellerVO.getSeller_id());
			 FileUtils.moveFileToDirectory(srcFile, destDir, true);
		 }
		 _sellerVO.setSeller_img1(sellerImage);
		sellerService.modSeller(_sellerVO);

		 mav.setViewName("redirect:/member/myPageMain.do?page=sellerPage"); 
		return mav;
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
		HttpSession session = multipartRequest.getSession();
		
		SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		String seller_id = sellerVO.getSeller_id();
		modGoodsMap.put("seller_id", seller_id);
		
		Map<String, Object> goodsInfo = sellerService.getGoodsInfo(goods_id);


	    
	    modGoodsMap.put("image_id", goodsInfo.get("goods_image_name1_id"));
		// 이미지1 처리
	       List<MultipartFile> image1FileList = multipartRequest.getFiles("goods_image_name1");
	       for (MultipartFile file : image1FileList) {
	           String fileName = file.getOriginalFilename();
	         
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
	       
	           goodsVO.setGoods_image_name2(fileName);
	           // 이미지2 처리 로직
	           ImageFileVO imageFileVO = new ImageFileVO();
	           imageFileVO.setFileName(fileName);
	           modGoodsMap.put("goods_image_name2", fileName);
	           modGoodsMap.put("detailFile", fileName);
	       }
	     
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name=(String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
			modGoodsMap.put(name, value);
			
		}
		
		List<String> imageFileName = upload(multipartRequest);
	    
		  sellerService.updateGoods(modGoodsMap);
		  sellerService.updateGoodsImage(modGoodsMap);
		
		
		  try {
			  
			  if (imageFileName != null && !imageFileName.isEmpty()) {
				    for (String fileName : imageFileName) {
				        File srcFile = new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + fileName);
				        File destDir = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id);
				        

				        // 이미지 파일을 옮깁니다.
				        FileUtils.moveFileToDirectory(srcFile, destDir, true);
				    }
				    
				    // 이미지 파일을 옮긴 후 기존 파일 삭제
				    String goods_image_name1 = (String) goodsInfo.get("goods_image_name1");
				    if (goods_image_name1 != null && !goods_image_name1.isEmpty()) {
				        File oldFile1 = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id + "\\" + goods_image_name1);
				        oldFile1.delete();
	
				    }

				    String goods_image_name2 = (String) goodsInfo.get("goods_image_name2");
				    if (goods_image_name2 != null && !goods_image_name2.isEmpty()) {
				        File oldFile2 = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id + "\\" + goods_image_name2);
				        oldFile2.delete();
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
	   
	   //사업자 등록상품리스트
	   /*@RequestMapping(value="/listSellerGoods.do", method={RequestMethod.POST,RequestMethod.GET})
	   public ModelAndView goodsList(HttpServletRequest request, HttpServletResponse response) throws Exception {
	       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");

	       // 사용자의 로그인 정보를 어떻게 가져올지에 따라 sellerId 변수를 설정
	       HttpSession session = request.getSession();
	      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	      String seller_id = sellerVO.getSeller_id();
	       List<GoodsVO> sellerGoodsList = sellerService.adminGoodsList(seller_id);
	       mav.addObject("sellerGoodsList", sellerGoodsList);
	       return mav;
	   }*/
	   @RequestMapping(value = "/listSellerGoods.do", method = { RequestMethod.POST, RequestMethod.GET })
	   public ModelAndView goodsList(HttpServletRequest request, HttpServletResponse response,
	           @RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
	       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");

	       HttpSession session = request.getSession();
	       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	       String seller_id = sellerVO.getSeller_id();

	       int itemsPerPage = 10;
	       int startIndex = (currentPage - 1) * itemsPerPage;

	       // 총 상품 개수 가져오기
	       int totalItemCount = sellerService.getGoodsListCount(seller_id);

	       // 상품 목록 조회
	       List<GoodsVO> sellerGoodsList = sellerService.adminGoodsList(seller_id, startIndex, itemsPerPage);

	       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
	       mav.addObject("sellerGoodsList", sellerGoodsList);
	       mav.addObject("totalPages", totalPages);
	       mav.addObject("currentPage", currentPage);
	       System.out.println(totalPages);
	       System.out.println(currentPage);

	       return mav;
	   }
	   
	   
	   
	  //오늘등록 상품조회
	    @RequestMapping(value = "/getTodayGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getTodayGoods(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getTodayGoodsCount(seller_id);
		       // 상품 목록 조회
		       List<GoodsVO> sellerGoodsList = sellerService.getTodayGoods(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerGoodsList", sellerGoodsList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       System.out.println(totalItemCount);
		       System.out.println(currentPage);
		       return mav;
		   }
	   
	    @RequestMapping(value = "/getOneWeekGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getOneWeekGoods(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getOneWeekGoodsCount(seller_id);
		       // 상품 목록 조회
		       List<GoodsVO> sellerGoodsList = sellerService.getOneWeekGoods(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerGoodsList", sellerGoodsList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       System.out.println(totalItemCount);
		       System.out.println(currentPage);
		       return mav;
		   }
	    
	    @RequestMapping(value = "/getTwoWeekGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getTwoWeekGoods(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getTwoWeekGoodsCount(seller_id);
		       // 상품 목록 조회
		       List<GoodsVO> sellerGoodsList = sellerService.getTwoWeekGoods(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerGoodsList", sellerGoodsList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       System.out.println(totalItemCount);
		       System.out.println(currentPage);
		       return mav;
		   }
	    
	    @RequestMapping(value = "/getOneMonthGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getOneMonthGoods(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getOneMonthGoodsCount(seller_id);
		       // 상품 목록 조회
		       List<GoodsVO> sellerGoodsList = sellerService.getOneMonthGoods(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerGoodsList", sellerGoodsList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       System.out.println(totalItemCount);
		       System.out.println(currentPage);
		       return mav;
		   }
	    @RequestMapping(value = "/getTwoMonthGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getTwoMonthGoods(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getTwoMonthGoodsCount(seller_id);
		       // 상품 목록 조회
		       List<GoodsVO> sellerGoodsList = sellerService.getTwoMonthGoods(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerGoodsList", sellerGoodsList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       System.out.println(totalItemCount);
		       System.out.println(currentPage);
		       return mav;
		   }
	    
	    @RequestMapping(value = "/getThreeMonthGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getThreeMonthGoods(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getThreeMonthGoodsCount(seller_id);
		       // 상품 목록 조회
		       List<GoodsVO> sellerGoodsList = sellerService.getThreeMonthGoods(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerGoodsList", sellerGoodsList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       System.out.println(totalItemCount);
		       System.out.println(currentPage);
		       return mav;
		   }
	    @RequestMapping(value = "/getFourMonthGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getFourMonthGoods(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getFourMonthGoodsCount(seller_id);
		       // 상품 목록 조회
		       List<GoodsVO> sellerGoodsList = sellerService.getFourMonthGoods(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerGoodsList", sellerGoodsList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       System.out.println(totalItemCount);
		       System.out.println(currentPage);
		       return mav;
		   }
	    
	    @RequestMapping(value = "/getDateGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getDateGoods(HttpServletRequest request, HttpServletResponse response,
	            @RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate,
	            @RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
	        ModelAndView mav = new ModelAndView("/seller/listSellerGoods");
	        HttpSession session = request.getSession();
	        SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	        String seller_id = sellerVO.getSeller_id();
	        int itemsPerPage = 10; // 페이지당 상품 개수
	        int startIndex = (currentPage - 1) * itemsPerPage;

	        Map<String, Object> getDateGoodsMap = new HashMap<>();
	        getDateGoodsMap.put("seller_id", seller_id);
	        getDateGoodsMap.put("startDate", startDate);
	        getDateGoodsMap.put("endDate", endDate);
	        getDateGoodsMap.put("startIndex", startIndex);
	        getDateGoodsMap.put("itemsPerPage", itemsPerPage);

	        List<GoodsVO> sellerGoodsList = sellerService.getDateGoods(getDateGoodsMap);
	        int totalItemCount = sellerService.getDateGoodsCount(getDateGoodsMap);
	        int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);

	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.addObject("totalPages", totalPages);
	        mav.addObject("currentPage", currentPage);
	        mav.addObject("startDate", startDate);
	        mav.addObject("endDate", endDate);

	        return mav;
	    }
	
	    
	    
	   
	// 사업자가등록한 사용자주문목록
	    @RequestMapping(value = "/listSellerOrder.do",method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderList(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerOrder");

		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();

		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;

		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getSellerOrderListCount(seller_id);

		       // 상품 목록 조회
		       List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderList(seller_id, startIndex, itemsPerPage);

		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerOrderList", sellerOrderList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       System.out.println(totalPages);
		       System.out.println(currentPage);

		       return mav;
		   }
	    
	    //당일
	    @RequestMapping(value = "/getSellerOrderListTODAY.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderListTODAY(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getSellerOrderListTODAYCount(seller_id);
		       // 상품 목록 조회
		       List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListTODAY(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerOrderList", sellerOrderList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       return mav;
		   }
	    //1주 오더
	    @RequestMapping(value = "/getSellerOrderListONEWEEK.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderListONEWEEK(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getSellerOrderListONEWEEKCount(seller_id);
		       // 상품 목록 조회
		       List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListONEWEEK(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerOrderList", sellerOrderList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       return mav;
		   }
	    
	    //2주 오더
	    @RequestMapping(value = "/getSellerOrderListTWOWEEK.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderListTWOWEEK(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getSellerOrderListTWOWEEKCount(seller_id);
		       // 상품 목록 조회
		       List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListTWOWEEK(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerOrderList", sellerOrderList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       return mav;
		   }
	    //1달 오더
	    @RequestMapping(value = "/getSellerOrderListONEMONTH.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderListONEMONTH(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getSellerOrderListONEMONTHCount(seller_id);
		       // 상품 목록 조회
		       List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListONEMONTH(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerOrderList", sellerOrderList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       return mav;
		   }
	    //2달 오더
	    @RequestMapping(value = "/getSellerOrderListTWOMONTH.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderListTWOMONTH(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getSellerOrderListTWOMONTHCount(seller_id);
		       // 상품 목록 조회
		       List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListTWOMONTH(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerOrderList", sellerOrderList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       return mav;
		   }
	    //3달
	    @RequestMapping(value = "/getSellerOrderListTHREEMONTH.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderListTHREEMONTH(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getSellerOrderListTHREEMONTHCount(seller_id);
		       // 상품 목록 조회
		       List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListTHREEMONTH(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerOrderList", sellerOrderList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       return mav;
		   }
	    //4달
	    @RequestMapping(value = "/getSellerOrderListFOURMONTH.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderListFOURMONTH(HttpServletRequest request, HttpServletResponse response,
	    		@RequestParam(value = "pageNum", defaultValue = "1") int currentPage) throws Exception {
		       ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
		       HttpSession session = request.getSession();
		       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		       String seller_id = sellerVO.getSeller_id();
		       int itemsPerPage = 10;
		       int startIndex = (currentPage - 1) * itemsPerPage;
		       // 총 상품 개수 가져오기
		       int totalItemCount = sellerService.getSellerOrderListFOURMONTHCount(seller_id);
		       // 상품 목록 조회
		       List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListFOURMONTH(seller_id, startIndex, itemsPerPage);
		       int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
		       mav.addObject("sellerOrderList", sellerOrderList);
		       mav.addObject("totalPages", totalPages);
		       mav.addObject("currentPage", currentPage);
		       return mav;
		   }
	    //정하기
	    @RequestMapping(value = "/getSellerOrderListDATE.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView getSellerOrderListDATE(
	        HttpServletRequest request,
	        HttpServletResponse response,
	        @RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
	        @RequestParam("startDate") String startDate,
	        @RequestParam("endDate") String endDate
	    ) throws Exception {
	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        HttpSession session = request.getSession();
	        SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	        String seller_id = sellerVO.getSeller_id();
	        int itemsPerPage = 10;
	        int startIndex = (currentPage - 1) * itemsPerPage;

	        // 파라미터를 맵 형태로 저장
	        Map<String, Object> getDateGoodsMap = new HashMap<>();
	        getDateGoodsMap.put("seller_id", seller_id);
	        getDateGoodsMap.put("startDate", startDate);
	        getDateGoodsMap.put("endDate", endDate);
	        getDateGoodsMap.put("startIndex", startIndex);
	        getDateGoodsMap.put("itemsPerPage", itemsPerPage);

	        // 총 상품 개수 가져오기
	        int totalItemCount = sellerService.getSellerOrderListDATECount(seller_id, startDate, endDate);

	        // 상품 목록 조회
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListDATE(getDateGoodsMap);

	        int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
	        mav.addObject("sellerOrderList", sellerOrderList);
	        mav.addObject("totalPages", totalPages);
	        mav.addObject("currentPage", currentPage);

	        // 시작 날짜와 종료 날짜도 뷰에 전달
	        mav.addObject("startDate", startDate);
	        mav.addObject("endDate", endDate);

	        return mav;
	    }
	    
	    //상품 상태 변경

	    @Override
	    @RequestMapping("/updateDeliveryStatus")
	    public ModelAndView updateDeliveryStatus(@RequestParam("order_id") int order_id,
	                                             @RequestParam("delivery_status") String delivery_status,
	                                             @RequestParam("orderNO") int orderNO,
	                                             HttpServletRequest request,
	                                             HttpServletResponse response) throws Exception{
	    	HttpSession session = request.getSession();
		    SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	        ModelAndView mav = new ModelAndView();
	        try {
	        	 Map<String, Object> deliveryStatusMap = new HashMap<>();
	        	 deliveryStatusMap.put("orderNO", orderNO);
	             deliveryStatusMap.put("order_id", order_id);
	             deliveryStatusMap.put("delivery_status", delivery_status);
	            sellerService.updateDeliveryStatus(deliveryStatusMap);
	            mav.addObject("message", "주문 상태가 업데이트되었습니다.");
	        } catch (Exception e) {
	            mav.addObject("message", "주문 상태 업데이트에 실패하였습니다.");
	            e.printStackTrace();
	        }
	        
	        mav.setViewName("redirect:/seller/listSellerOrder.do?page=sellerPage"); // 결과 페이지 이름
	        
	        return mav;
	    }
	    
	    
	    
	    //사업자 qna리스트
	   /* @Override
	    @RequestMapping("/sellerQuestionAnswer.do")
	    public ModelAndView selectAllGoodsQna(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView("/seller/sellerQuestionAnswer");
	        HttpSession session = request.getSession();
	        SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	        String seller_id = sellerVO.getSeller_id();
	        System.out.println(seller_id);
	        Map<String, Object> goodsQnaMap = new HashMap<>();
	        goodsQnaMap.put("seller_id", seller_id);

	        // 서비스에서 데이터 가져와서 goodsQnaMap에 넣기
	        List<GoodsQNA> goodsQnaList = sellerService.selectAllGoodsQna(goodsQnaMap);

	        for (GoodsQNA goodsQna : goodsQnaList) {
	            System.out.println("Question: " + goodsQna.getArticleNO());
	            System.out.println("Answer: " + goodsQna.getGoods_qna_content());
	            // 기타 필요한 정보들도 출력
	        }

	        mav.addObject("goodsQnaList", goodsQnaList); // 모델에 데이터 추가
	        return mav;
	    }*/
	    @RequestMapping(value = "/sellerQuestionAnswer.do", method = { RequestMethod.POST, RequestMethod.GET })
	    public ModelAndView selectAllGoodsQna(HttpServletRequest request,
	                                          @RequestParam(name = "searchWord", required = false) String searchWord,
	                                          @RequestParam(name = "pageNum", defaultValue = "1") int currentPage)
	            throws Exception {
	        ModelAndView mav = new ModelAndView("/seller/sellerQuestionAnswer");
	        HttpSession session = request.getSession();
	        SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	        String seller_id = sellerVO.getSeller_id();

	        // 전체 항목 수 가져오기
	        int totalItemCount = sellerService.selectAllGoodsQnaCount(seller_id);

	        // 페이지당 항목 수와 시작 인덱스 계산
	        int itemsPerPage = 10;// 페이지당 항목 수를 원하는 값으로 설정하세요
	        int startIndex = (currentPage - 1) * itemsPerPage;
	        int totalPages = (int) Math.ceil((double) totalItemCount / itemsPerPage);
	        // 검색 결과 가져오기
	        Map<String, Object> goodsQnaMap = new HashMap<>();
	        goodsQnaMap.put("seller_id", seller_id);
	        goodsQnaMap.put("startIndex", startIndex);
	        goodsQnaMap.put("itemsPerPage", itemsPerPage);

	        List<GoodsQNA> goodsQnaList = sellerService.selectAllGoodsQna(goodsQnaMap);

	        if (searchWord != null && !searchWord.isEmpty()) {
	            String sanitizedSearchWord = searchWord.replaceAll("\\s+", ""); // 모든 공백 제거
	            List<GoodsQNA> filteredGoodsQnaList = new ArrayList<>();
	            	
	            for (GoodsQNA goodsQna : goodsQnaList) {
	                if (goodsQna.getGoods_qna_content().replaceAll("\\s+", "").contains(sanitizedSearchWord) ||
	                    goodsQna.getGoods_qna_title().replaceAll("\\s+", "").contains(sanitizedSearchWord) ||
	                    goodsQna.getGoods_qna_middle_title().replaceAll("\\s+", "").contains(sanitizedSearchWord)) {
	                	
	                    filteredGoodsQnaList.add(goodsQna);
	                }
	            }
	            goodsQnaList = filteredGoodsQnaList;
	            
	        }
	        List goodsQNAList = new ArrayList();
	        if(goodsQnaList!=null) {
	        	
            for(int i=0; i<goodsQnaList.size(); i++) {
            	GoodsQNA goodsQNA =  goodsQnaList.get(i);
            	 String goods_id= goodsQNA.getGoods_id();
            	 Map goodsDetail= goodsService.goodsDetail(goods_id);
            	 GoodsVO goodsVO = (GoodsVO) goodsDetail.get("goodsVO");
            	 goodsQnaList.remove(i);
            	 goodsQNA.setGoodsVO(goodsVO);
            	 goodsQNAList.add(goodsQNA);
            	}	
	        }
	        mav.addObject("totalPages", totalPages);
	        mav.addObject("goodsQnaList", goodsQNAList);
	        mav.addObject("totalItemCount", totalItemCount);
	        mav.addObject("itemsPerPage", itemsPerPage);
	        mav.addObject("currentPage", currentPage);
	        System.out.println(totalItemCount);
	        System.out.println(currentPage);
	        System.out.println(startIndex);
	        return mav;
	    }
	   
	    
	    
	    //사업자 qna답변
	    @RequestMapping("/addGoodsQnaAnswer.do")
	    public ModelAndView addGoodsQnaAnswer(@RequestParam Map<String, Object> goodsQnaAnswerMap,
	                                          HttpServletRequest request) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        request.setCharacterEncoding("utf-8");

	        HttpSession session = request.getSession();
	        String seller_id = ((SellerVO) session.getAttribute("memberInfo")).getSeller_id();
	        String goods_qna_answer = request.getParameter("goods_qna_answer");
	        String articleNOString = request.getParameter("articleNO");
	        int articleNO = Integer.parseInt(articleNOString);

	        goodsQnaAnswerMap.put("goods_qna_answer", goods_qna_answer);
	        goodsQnaAnswerMap.put("seller_id", seller_id);
	        goodsQnaAnswerMap.put("articleNO", articleNO);
	        System.out.println(goodsQnaAnswerMap.get("goods_qna_answer"));
	        System.out.println(goodsQnaAnswerMap.get("articleNO"));
	        sellerService.addGoodsQnaAnswer(goodsQnaAnswerMap);
	        mav.setViewName("redirect:/seller/sellerQuestionAnswer.do?page=sellerPage");// 답변 처리 후 리다이렉트할 페이지 주소 설정
	        return mav;
	    }
	    
	    @RequestMapping("/sellerOrderDetail.do")
	    public ModelAndView sellerOrderDetail(@RequestParam("order_id") String order_id,
	                                          HttpServletRequest request,
	                                          HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        request.setCharacterEncoding("utf-8");
	        HttpSession session = request.getSession();
	        SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	        String seller_id = sellerVO.getSeller_id();
	        System.out.println(seller_id);
	        
	        Map<String, Object> orderInfoMap = new HashMap<>();
	        orderInfoMap.put("order_id", order_id);
	        orderInfoMap.put("seller_id", seller_id);

	        try {
	            // sellerOrderInfo 서비스 메서드를 호출하여 주문 및 환불 정보를 가져옵니다.
	            List<Map<String, Object>> orderInfoList = sellerService.sellerOrderInfo(orderInfoMap);

	            // 모델에 데이터를 추가하여 JSP 페이지로 전달합니다.
	            mav.addObject("orderInfoList", orderInfoList);

	            // JSP 페이지 이름을 설정합니다. 해당 JSP 페이지는 orderInfoList 데이터를 활용하여 화면을 구성합니다.
	            mav.setViewName("/seller/sellerOrderDetail");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

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
