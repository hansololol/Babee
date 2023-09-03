package com.babee.member.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.babee.common.base.BaseController;
import com.babee.member.service.MemberService;
import com.babee.member.vo.MemberVO;
import com.babee.mypage.service.MyPageService;
import com.babee.seller.service.SellerService;
import com.babee.seller.vo.SellerVO;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;



@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl extends BaseController implements MemberController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private SellerService sellerService;
	@Autowired
	private MyPageService mypageService;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private SellerVO sellerVO;
	@Autowired
	public JavaMailSender javaMailSender;

	@Async
	public void sendMail(String email, String message) {
		SimpleMailMessage simpleMessage = new SimpleMailMessage();
		simpleMessage.setFrom("ekfkawnl9593@naver.com"); 
		simpleMessage.setTo(email);
		simpleMessage.setSubject("Babee 인증번호 전송해드립니다.");
		simpleMessage.setText("인증번호: " +  message);
		javaMailSender.send(simpleMessage);
	}
	
	@Override
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		 memberVO=memberService.login(loginMap);
		 sellerVO=sellerService.login(loginMap);
		 String member_id = loginMap.get("member_id");
		List wish = mypageService.selectWishList(member_id);
		 HttpSession session=request.getSession();
			session=request.getSession();
		if(memberVO != null){
			session.setAttribute("isLogOn", true);
			session.setAttribute("userType", "M");
			session.setAttribute("memberInfo",memberVO);
			session.setAttribute("wishList", wish);
			mav.setViewName("redirect:/main/main.do");
			
		}else if(sellerVO!=null) {
			session.setAttribute("isLogOn", true);
			session.setAttribute("userType", "S");
			session.setAttribute("memberInfo",sellerVO);
			session.setAttribute("wishList", wish);
			mav.setViewName("redirect:/main/main.do");
		}else {
			mav.addObject("falseLog", "falseLog");
			mav.setViewName("/member/loginForm");
		}

		return mav;
	}
	
	@Override
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.removeAttribute("isLogOn");
		session.removeAttribute("memberInfo");
		session.removeAttribute("userType");
		session.removeAttribute("wishList");
		String memberpw= (String) session.getAttribute("memberpw");
		if(memberpw !=null) {
			session.removeAttribute("memberpw");
		}
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/memberDel.do" ,method = RequestMethod.GET)
	public ModelAndView memberDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		MemberVO member= (MemberVO) session.getAttribute("memberInfo");
		String pw= request.getParameter("member_pw");
		String id = member.getMember_id();
		String pw2 = member.getMember_pw();
		if(pw.equals(pw2)) {
		memberService.delMember(id);
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		session.removeAttribute("userType");
		String memberpw= (String) session.getAttribute("memberpw");
		if(memberpw !=null) {
			session.removeAttribute("memberpw");
		}
		mav.addObject("alertMember", "success");
		mav.setViewName("redirect:/main/main.do");
		}else {
		mav.addObject("alertMember", "fail");
		mav.setViewName("redirect:/main/main.do");
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("memberVO") MemberVO _memberVO,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
		
		    memberService.addMember(_memberVO);
		    message  = "<script>";
		    message +=" alert('회원가입이 완료되었습니다. 로그인 해주시기 바랍니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('회원가입에 실패하였습니다. 다시 시도해주시기 바랍니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		String result = memberService.overlapped(id);
		resEntity =new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/findMyId.do" ,method = RequestMethod.POST)
	public ModelAndView findMyId(@RequestParam Map<String, String> findMap,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView("/member/findId");
		memberVO = memberService.findMyId(findMap);
		if(memberVO !=null ) {
		mav.addObject("findMember", memberVO);
		mav.addObject("nn", "y");
		
		}else {
			mav.addObject("nn", "n");
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/checkPw.do" ,method = RequestMethod.POST)
	public ModelAndView checkPw(@RequestParam Map<String, String> findMap,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView("/member/findId");
		int pwd = (int) Math.floor(Math.random()*1000000);
		String newPwd=String.valueOf(pwd);
		findMap.put("member_pw", newPwd);
		memberVO = memberService.findMyPw(findMap);
		if(memberVO !=null) {
		String email = memberVO.getMember_email();
		sendMail(email, newPwd);
		mav.addObject("message", "등록하신 이메일로 임시비밀번호가 발급되었습니다.");
		}else {
			mav.addObject("message", "등록된 회원 정보가 없습니다.");
		}
		return mav;
	}
	
	
	
	//異붽�以� 
	@RequestMapping(value="/updateMember.do" , method= RequestMethod.POST)
	public ModelAndView modMember(@ModelAttribute("memberVO") MemberVO _memberVO, HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		memberService.modMember(_memberVO);
		 HttpSession session=request.getSession();
		session.setAttribute("memberInfo",_memberVO);
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("redirect:/member/myPageMain.do"); 
		return mav;
	}
	//카카오 로그인
	@GetMapping(value="/kakao", produces = MediaType.APPLICATION_JSON_VALUE)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, HttpServletRequest request) throws Exception {	
		 System.out.println("OAuth Code : "+code);

		
	        String access_Token = getAccessToken(code);
	        Map<String, Object> userInfo = getUserInfo(access_Token);
	        String member_id = (String) userInfo.get("member_id");
		       
	        if(memberService.overlapped(member_id).equals("false")) {
	        	 memberVO.setMember_name((String) userInfo.get("nickname"));
	        	 int random_pw = (int) Math.floor(Math.random()*100000);
	 	        String member_pw= String.valueOf(random_pw);
	 	        memberVO.setMember_id(member_id);
	        	memberVO.setMember_pw(member_pw);
                memberService.addMember(memberVO);
	        }
	        memberVO = memberService.findMyPw_kakao(userInfo);
	        String member_pw = memberVO.getMember_pw();
	        userInfo.put("member_pw", member_pw);
	        HttpSession session=request.getSession();
			session=request.getSession();
			memberVO=memberService.login(userInfo);
			if(memberVO != null){
			session.setAttribute("isLogOn", true);
			session.setAttribute("userType", "M");
			session.setAttribute("memberInfo",memberVO);
			session.setAttribute("memberpw",memberVO.getMember_pw());
			
		}
		    return "redirect:/main/main.do";
		}

	//네이버
		@RequestMapping(value="/naver.do" , method= RequestMethod.POST)
		@ResponseBody
		public ModelAndView naverLogin(@RequestParam("nickName") String nickName, @RequestParam("email") String email, HttpServletRequest request) throws Exception {	
			 ModelAndView mav = new ModelAndView();
			 Map userInfo = new HashMap();
			 userInfo.put("user_name", nickName);
			 userInfo.put("member_id", email);
			 if(memberService.overlapped(email).equals("false")) {
	        	 memberVO.setMember_name(nickName);
	        	 int random_pw = (int) Math.floor(Math.random()*100000);
	 	        String member_pw= String.valueOf(random_pw);
	 	        memberVO.setMember_id(email);
	        	memberVO.setMember_pw(member_pw);
                memberService.addMember(memberVO);
	        }
	        memberVO = memberService.findMyPw_kakao(userInfo);
	        String member_pw = memberVO.getMember_pw();
	        userInfo.put("member_pw", member_pw);
	        HttpSession session=request.getSession();
			session=request.getSession();
			memberVO=memberService.login(userInfo);
			if(memberVO != null){
			session.setAttribute("isLogOn", true);
			session.setAttribute("userType", "M");
			session.setAttribute("memberInfo",memberVO);
			session.setAttribute("memberpw",memberVO.getMember_pw());
			mav.setViewName("redirect:/main/main.do");		
		}
			 return mav;
			}

	

    public HashMap<String, Object> getUserInfo(String accessToken) throws IOException {
    	  HashMap<String, Object> userInfo = new HashMap<String, Object>();
          String requestURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(requestURL); //1.url 객체만들기
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            //2.url 에서 url connection 만들기
            conn.setRequestMethod("GET"); // 3.URL 연결구성
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            
            //키값, 속성 적용
            int responseCode = conn.getResponseCode(); //서버에서 보낸 http 상태코드 반환
            System.out.println("responseCode :" + responseCode+ "여긴가");
            BufferedReader buffer = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            // 버퍼를 사용하여 일근ㄴ것
            String line = "";
            String result = "";
            while ((line = buffer.readLine()) != null) {
                result +=line;
            }
            //readLine()) ==> 입력 String 값으로 리턴값 고정 
            
            System.out.println("response body :" +result);
            
            // 읽엇으니깐 데이터꺼내오기
          JsonParser parser = new JsonParser();
          JsonElement element = parser.parse(result); //Json element 문자열변경
          JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
          JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

          String nickname = properties.getAsJsonObject().get("nickname").getAsString();
          String id = element.getAsJsonObject().get("id").getAsString();

          userInfo.put("accessToken", accessToken);
          userInfo.put("nickname", nickname);
          userInfo.put("member_id", id);
    
            
        } catch (Exception e) {
           e.printStackTrace();
        }
        return userInfo;
    }
    
    public String getAccessToken(String code) throws IOException {
        //인가코드로 토큰 받기
        String accessToken = "";
        String refreshToken = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
//        	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=4951001851fc8c1183e352146ca720fd"); 
            sb.append("&redirect_uri=http://localhost:8080/member/kakao");
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            int responseCode = conn.getResponseCode();

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

            String line = "";
            String result = "";
            while((line = br.readLine())!=null) {
                result += line;
            }
            System.out.println("response body=" + result);


            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
 
            accessToken = element.getAsJsonObject().get("access_token").getAsString();
            String refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
 
            System.out.println("access_token : " + accessToken);
            System.out.println("refresh_token : " + refresh_Token);
 
            br.close();
            bw.close();
        } catch (IOException e) {
 
            e.printStackTrace();
        }
 
        return accessToken;

    }

	}
	

