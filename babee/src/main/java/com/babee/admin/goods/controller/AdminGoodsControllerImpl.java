package com.babee.admin.goods.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
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

import com.babee.admin.goods.dao.AdminGoodsDAO;
import com.babee.admin.goods.service.AdminGoodsService;
import com.babee.common.base.BaseController;
import com.babee.goods.vo.GoodsVO;
import com.babee.goods.vo.ImageFileVO;
import com.babee.member.vo.MemberVO;
import com.babee.seller.vo.SellerVO;

@Controller("adminGoodsController")
@RequestMapping(value="/admin/goods")
public class AdminGoodsControllerImpl extends BaseController  implements AdminGoodsController{
   private static final String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
   @Autowired
   private AdminGoodsService adminGoodsService;
   private AdminGoodsDAO adminGoodsDAO;
   Random random = new Random();
   @RequestMapping(value="/adminGoodsMain.do" ,method={RequestMethod.POST,RequestMethod.GET})
   public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,
                                    HttpServletRequest request, HttpServletResponse response)  throws Exception {
      String viewName=(String)request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      //HttpSession session=request.getSession();
      //session=request.getSession();
      //session.setAttribute("side_menu", "admin_mode"); //              永    嚥          髥  .
      
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
      
      Map<String,Object> condMap=new HashMap<String,Object>();
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
      List<GoodsVO> newGoodsList=adminGoodsService.listNewGoods(condMap);
      mav.addObject("newGoodsList", newGoodsList);
      
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
   

    
   @RequestMapping(value = "/addNewGoods.do", method = RequestMethod.POST)
   public ResponseEntity<String> addNewGoods(MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response)
           throws Exception {
       multipartRequest.setCharacterEncoding("utf-8");
       response.setContentType("text/html; charset=UTF-8");
       String imageFileName = null;
       //addNewGoodsImage(multipartRequest, request, response);
       Map<String, Object> newGoodsMap = new HashMap<>();
       GoodsVO goodsVO = new GoodsVO();

       // 이미지1 처리
       List<MultipartFile> image1FileList = multipartRequest.getFiles("goods_image_name1");
       for (MultipartFile file : image1FileList) {
           String fileName = file.getOriginalFilename();
           System.out.println("name1:" + fileName);
           goodsVO.setGoods_image_name1(fileName);

           // 이미지1 처리 로직
           ImageFileVO imageFileVO = new ImageFileVO();
           imageFileVO.setFileName(fileName);
           newGoodsMap.put("goods_image_name1", fileName);
           
           int randomNumber = random.nextInt(900000) + 100000;
           // goods_image_name1_id를 생성하여 newGoodsMap에 추가
           int goodsImageName1Id = randomNumber;
           newGoodsMap.put("goods_image_name1_id", goodsImageName1Id);
           
           // goodsVO에도 goods_image_name1_id 저장
           goodsVO.setGoods_image_name1_id(goodsImageName1Id);
           newGoodsMap.put("fileName", fileName);
       }

       // 이미지2 처리
       List<MultipartFile> image2FileList = multipartRequest.getFiles("goods_image_name2");
       for (MultipartFile file : image2FileList) {
           String fileName = file.getOriginalFilename();
           System.out.println("name2" + fileName);
           goodsVO.setGoods_image_name2(fileName);

           // 이미지2 처리 로직
           ImageFileVO imageFileVO = new ImageFileVO();
           imageFileVO.setFileName(fileName);
           newGoodsMap.put("goods_image_name2", fileName);
           
           int randomNumber = random.nextInt(900000) + 100000;
           // goods_image_name1_id를 생성하여 newGoodsMap에 추가
           int goodsImageName2Id = randomNumber;
           newGoodsMap.put("goods_image_name2_id", goodsImageName2Id);
           // goodsVO에도 goods_image_name1_id 저장
           goodsVO.setGoods_image_name1_id(goodsImageName2Id);
           newGoodsMap.put("detailFile", fileName);
       }

       Enumeration<String> enu = multipartRequest.getParameterNames();
       while (enu.hasMoreElements()) {
           String name = enu.nextElement();
           String value = multipartRequest.getParameter(name);
           newGoodsMap.put(name, value);
           System.out.println(name + ": " + value);
       }

       HttpSession session = multipartRequest.getSession();
       SellerVO sellerVO = (SellerVO) session.getAttribute("memberInfo");
       String reg_id = sellerVO.getSeller_id();
       sellerVO.setSeller_id(reg_id);
       System.out.println("셀러아이디" + reg_id);
       newGoodsMap.put("seller_id", reg_id);
       newGoodsMap.put("reg_id", reg_id);
       //ImageFileVO imageFileVO = new ImageFileVO();
       

       // 이미지 파일 업로드 로직
       List<ImageFileVO> imageFileList = upload(multipartRequest);
       newGoodsMap.put("imageFileList", imageFileList);
       
       String message = null;
       ResponseEntity<String> resEntity = null;
       HttpHeaders responseHeaders = new HttpHeaders();
       responseHeaders.add("Content-Type", "text/html; charset=utf-8");
       //int good_id = adminGoodsService.addNewGoods(newGoodsMap);
       
       
       adminGoodsService.addNewGoods(newGoodsMap);
       int goods_id = (int) newGoodsMap.get("goods_id");
       //adminGoodsService.addNewGoodsImage(newGoodsMap);
       //int goods_id = adminGoodsService.addNewGoods.get("goods_id"));
       System.out.println("zzzzzzz"+goods_id);
       try {
           if (imageFileList != null && imageFileList.size() != 0) {
               for (ImageFileVO imageFileVO : imageFileList) {
                  imageFileVO.setReg_id(reg_id);
                   imageFileName = imageFileVO.getFileName();
                   System.out.println("File name112221: " + imageFileName);
                   File srcFile = new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + imageFileName);
                   File destDir = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id);
                   FileUtils.moveFileToDirectory(srcFile, destDir, true);

               }
           }

           message = "<script>";
           message += " alert('성공!');";
           message += " location.href='" + multipartRequest.getContextPath() + "/seller/listSellerGoods.do?page=sellerPage';";
           message += ("</script>");
       } catch (Exception e) {
           if (imageFileList != null && imageFileList.size() != 0) {
               for (ImageFileVO imageFileVO : imageFileList) {
                   imageFileName = imageFileVO.getFileName();
                   File srcFile = new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + imageFileName);
                   srcFile.delete();
               }
               
           }
           message = "<script>";
           message += " alert('실패');";
           message += " location.href='" + multipartRequest.getContextPath() + "/seller/listSellerGoods.do?page=sellerPage';";
           message += ("</script>");
           e.printStackTrace();
       }
       
       resEntity = new ResponseEntity<>(message, responseHeaders, HttpStatus.OK);
       return resEntity;
   }
      
   @RequestMapping(value="/modifyGoodsForm.do" ,method={RequestMethod.GET,RequestMethod.POST})
   public ModelAndView modifyGoodsForm(@RequestParam("goods_id") int goods_id,
                                     HttpServletRequest request, HttpServletResponse response)  throws Exception {
      String viewName=(String)request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      
      Map goodsMap=adminGoodsService.goodsDetail(goods_id);
      mav.addObject("goodsMap",goodsMap);
      
      return mav;
   }
   
   @RequestMapping(value="/modifyGoodsInfo.do" ,method={RequestMethod.POST})
   public ResponseEntity modifyGoodsInfo( @RequestParam("goods_id") String goods_id,
                              @RequestParam("attribute") String attribute,
                              @RequestParam("value") String value,
         HttpServletRequest request, HttpServletResponse response)  throws Exception {
      //System.out.println("modifyGoodsInfo");
      
      Map<String,String> goodsMap=new HashMap<String,String>();
      goodsMap.put("goods_id", goods_id);
      goodsMap.put(attribute, value);
      adminGoodsService.modifyGoodsInfo(goodsMap);
      
      String message = null;
      ResponseEntity resEntity = null;
      HttpHeaders responseHeaders = new HttpHeaders();
      message  = "mod_success";
      resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
      return resEntity;
   }
   

   @RequestMapping(value="/modifyGoodsImageInfo.do" ,method={RequestMethod.POST})
   public void modifyGoodsImageInfo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
      System.out.println("modifyGoodsImageInfo");
      multipartRequest.setCharacterEncoding("utf-8");
      response.setContentType("text/html; charset=utf-8");
      String imageFileName=null;
      
      Map goodsMap = new HashMap();
      Enumeration enu=multipartRequest.getParameterNames();
      while(enu.hasMoreElements()){
         String name=(String)enu.nextElement();
         String value=multipartRequest.getParameter(name);
         goodsMap.put(name,value);
      }
      
      HttpSession session = multipartRequest.getSession();
      MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
      String reg_id = memberVO.getMember_id();
      
      List<ImageFileVO> imageFileList=null;
      int goods_id=0;
      int image_id=0;
      try {
         imageFileList =upload(multipartRequest);
         if(imageFileList!= null && imageFileList.size()!=0) {
            for(ImageFileVO imageFileVO : imageFileList) {
               goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
               image_id = Integer.parseInt((String)goodsMap.get("image_id"));
               imageFileVO.setGoods_id(goods_id);
               imageFileVO.setImage_id(image_id);
               imageFileVO.setReg_id(reg_id);
            }
            
             adminGoodsService.modifyGoodsImage(imageFileList);
            for(ImageFileVO  imageFileVO:imageFileList) {
               imageFileName = imageFileVO.getFileName();
               File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
               File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
               FileUtils.moveFileToDirectory(srcFile, destDir,true);
            }
         }
      }catch(Exception e) {
         if(imageFileList!=null && imageFileList.size()!=0) {
            for(ImageFileVO  imageFileVO:imageFileList) {
               imageFileName = imageFileVO.getFileName();
               File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
               srcFile.delete();
            }
         }
         e.printStackTrace();
      }
      
   }
   

 //관리자 상품조회
   @RequestMapping(value = "/listSellerGoodsAdmin.do")
   public ModelAndView allGoodsList(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   ModelAndView mav = new ModelAndView();
	   HttpSession session=request.getSession();
	   MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
	   try {
           List<GoodsVO> allGoodsList = adminGoodsService.allGoodsList();
           mav.addObject("allGoodsList", allGoodsList);
           mav.setViewName("/admin/goods/listSellerGoodsAdmin"); // 상품 리스트를 보여줄 뷰 페이지 지정
       } catch (Exception e) {
           e.printStackTrace();
       }

       return mav;
   }
   
   
   
   //관리자 상품삭제
   @Override
   @RequestMapping(value = "/removeGoodsImage.do", method={RequestMethod.GET, RequestMethod.POST})
   public void removeGoodsImage(@RequestParam("goods_id") int goods_id,
		   						@RequestParam("goods_image_name1_id") int goods_image_name1_id,
                                HttpServletRequest request, HttpServletResponse response) throws Exception {
  
       
       try {
          adminGoodsService.removeGoodsImage1(goods_id);
          adminGoodsService.removeGoodsImage2(goods_image_name1_id);
          
           // 폴더 삭제
           File srcFolder = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id);
           deleteDirectory(srcFolder);

           response.sendRedirect(request.getContextPath() + "/admin/goods/listSellerGoodsAdmin.do");
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



   /*@Override
   @RequestMapping(value="/removeGoodsImage.do" ,method={RequestMethod.POST})
   public void  removeGoodsImage(@RequestParam("goods_id") int goods_id,
                               @RequestParam("image_id") int image_id,
                               @RequestParam("imageFileName") String imageFileName,
                               HttpServletRequest request, HttpServletResponse response)  throws Exception {
      
      adminGoodsService.removeGoodsImage(image_id);
      try{
         File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+imageFileName);
         srcFile.delete();
      }catch(Exception e) {
         e.printStackTrace();
      }
   }*/

}