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
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
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
	   @RequestMapping(value="/listSellerGoods.do", method={RequestMethod.POST,RequestMethod.GET})
	   public ModelAndView goodsList(HttpServletRequest request, HttpServletResponse response) throws Exception {
	       ModelAndView mav = new ModelAndView("/seller/listSellerGoods");

	       // 사용자의 로그인 정보를 어떻게 가져올지에 따라 sellerId 변수를 설정
	       HttpSession session = request.getSession();
	      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	      String seller_id = sellerVO.getSeller_id();
	       List<GoodsVO> sellerGoodsList = sellerService.adminGoodsList(seller_id);
	       mav.addObject("sellerGoodsList", sellerGoodsList);
	       return mav;
	   }
	   
	   
	   
	  //오늘등록 상품조회
	    @RequestMapping(value = "/getTodayGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getTodayGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
		      List<GoodsVO> sellerGoodsList = sellerService.getTodayGoods(seller_id);
	        
	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.setViewName("/seller/listSellerGoods"); // 오늘 등록된 상품 목록을 보여줄 뷰 페이지 이름 지정
	        
	        return mav;
	    }
	   
	    @RequestMapping(value = "/getOneWeekGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getOneWeekGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();

		      
		      List<GoodsVO> sellerGoodsList = sellerService.getOneWeekGoods(seller_id);
	        
	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.setViewName("/seller/listSellerGoods");
	        
	        return mav;
	    }
	    @RequestMapping(value = "/getTwoWeekGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getTwoWeekGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();

		      
		      List<GoodsVO> sellerGoodsList = sellerService.getTwoWeekGoods(seller_id);
	        
	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.setViewName("/seller/listSellerGoods"); 
	        
	        return mav;
	    }
	    @RequestMapping(value = "/getTwoMonthGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getTwoMonthGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();

		      
		      List<GoodsVO> sellerGoodsList = sellerService.getTwoMonthGoods(seller_id);
	        
	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.setViewName("/seller/listSellerGoods"); 
	        
	        return mav;
	    }
	    @RequestMapping(value = "/getOneMonthGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getOneMonthGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();

		      
		      List<GoodsVO> sellerGoodsList = sellerService.getOneMonthGoods(seller_id);
	        
	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.setViewName("/seller/listSellerGoods"); 
	        
	        return mav;
	    }
	    @RequestMapping(value = "/getThreeMonthGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getThreeMonthGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();

		      
		      List<GoodsVO> sellerGoodsList = sellerService.getThreeMonthGoods(seller_id);
	        
	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.setViewName("/seller/listSellerGoods"); 
	        
	        return mav;
	    }
	    @RequestMapping(value = "/getFourMonthGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getFourMonthGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();

		      
		      List<GoodsVO> sellerGoodsList = sellerService.getFourMonthGoods(seller_id);
	        
	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.setViewName("/seller/listSellerGoods"); 
	        
	        return mav;
	    }
	    
	    @RequestMapping(value = "/getDateGoods.do", method = { RequestMethod.GET, RequestMethod.POST })
	    public ModelAndView getDateGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        ModelAndView mav = new ModelAndView();
	        HttpSession session = request.getSession();
	        SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	        String seller_id = sellerVO.getSeller_id();
	        String startDate = request.getParameter("startDate");
	        String endDate = request.getParameter("endDate");
	        Map<String, Object> getDateGoodsMap = new HashMap<>();
	          
	        getDateGoodsMap.put("seller_id", seller_id);
	        getDateGoodsMap.put("startDate", startDate);
	        getDateGoodsMap.put("endDate", endDate);
	        System.out.println(startDate);
	        System.out.println(endDate);
	        List<Map<String, Object>> sellerGoodsList = sellerService.getDateGoods(getDateGoodsMap);
	        
	        mav.addObject("sellerGoodsList", sellerGoodsList);
	        mav.setViewName("/seller/listSellerGoods"); 
	        
	        return mav;
	    }
	    
	    
	   
	// 사업자가등록한 사용자주문목록
	    @Override
	    @RequestMapping(value = "/listSellerOrder.do")
	    public ModelAndView getSellerOrderList(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderList(seller_id);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    @RequestMapping(value = "/getSellerOrderListTODAY.do")
	    public ModelAndView getSellerOrderListTODAY(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListTODAY(seller_id);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    @RequestMapping(value = "/getSellerOrderListONEWEEK.do")
	    public ModelAndView getSellerOrderListONEWEEK(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListONEWEEK(seller_id);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    @RequestMapping(value = "/getSellerOrderListTWOWEEK.do")
	    public ModelAndView getSellerOrderListTWOWEEK(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListTWOWEEK(seller_id);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    @RequestMapping(value = "/getSellerOrderListONEMONTH.do")
	    public ModelAndView getSellerOrderListONEMONTH(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListONEMONTH(seller_id);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    @RequestMapping(value = "/getSellerOrderListTWOMONTH.do")
	    public ModelAndView getSellerOrderListTWOMONTH(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListTWOMONTH(seller_id);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    @RequestMapping(value = "/getSellerOrderListTHREEMONTH.do")
	    public ModelAndView getSellerOrderListTHREEMONTH(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListTHREEMONTH(seller_id);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    @RequestMapping(value = "/getSellerOrderListFOURMONTH.do")
	    public ModelAndView getSellerOrderListFOURMONTH(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	HttpSession session = request.getSession();
		      SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
		      String seller_id = sellerVO.getSeller_id();
	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListFOURMONTH(seller_id);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    @RequestMapping(value = "/getSellerOrderListDATE.do")
	    public ModelAndView getSellerOrderListDATE(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        HttpSession session = request.getSession();
	        SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	        String seller_id = sellerVO.getSeller_id();
	        String startDate = request.getParameter("startDate");
	        String endDate = request.getParameter("endDate");
	        Map<String, Object> getSellerOrderList = new HashMap<>();

	        getSellerOrderList.put("seller_id", seller_id);
	        getSellerOrderList.put("startDate", startDate);
	        getSellerOrderList.put("endDate", endDate);
	        System.out.println(startDate);
	        System.out.println(endDate);

	        List<Map<String, Object>> sellerOrderList = sellerService.getSellerOrderListDATE(seller_id, startDate, endDate);

	        ModelAndView mav = new ModelAndView("/seller/listSellerOrder");
	        mav.addObject("sellerOrderList", sellerOrderList);
	        return mav;
	    }
	    
	    //상품 상태 변경

	    @Override
	    @RequestMapping("/updateDeliveryStatus")
	    public ModelAndView updateDeliveryStatus(@RequestParam("order_id") int order_id,
	                                             @RequestParam("delivery_status") String delivery_status,
	                                             HttpServletRequest request,
	                                             HttpServletResponse response) throws Exception{
	    	HttpSession session = request.getSession();
		    SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
	    	
	    	System.out.println("실행됨.,.");
	    	
	        ModelAndView mav = new ModelAndView();
	        try {
	        	 Map<String, Object> deliveryStatusMap = new HashMap<>();
	             deliveryStatusMap.put("order_id", order_id);
	             deliveryStatusMap.put("delivery_status", delivery_status);
	            sellerService.updateDeliveryStatus(deliveryStatusMap);
	            System.out.println("오더아이!!!디: "+order_id);
		        System.out.println("상태!!!!!!!값: "+delivery_status);
	            mav.addObject("message", "주문 상태가 업데이트되었습니다.");
	        } catch (Exception e) {
	            mav.addObject("message", "주문 상태 업데이트에 실패하였습니다.");
	            e.printStackTrace();
	        }
	        
	        mav.setViewName("redirect:/seller/listSellerOrder.do?page=sellerPage"); // 결과 페이지 이름
	        
	        return mav;
	    }
	    
	    
	    
	    //사업자 qna리스트
	    @Override
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
