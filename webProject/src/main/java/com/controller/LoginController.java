package com.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.service.LoginService;

@Controller
public class LoginController {
    private static String RSA_WEB_KEY = "_RSA_WEB_Key_"; // 媛쒖씤�궎 session key
    private static String RSA_INSTANCE = "RSA"; // rsa transformation
	
	@Resource(name="loginService")
	private LoginService loginService;

	@RequestMapping(value = "/loginForm")
	public ModelAndView loginForm(HttpServletRequest request, HttpServletResponse response) {
		// RSA �궎 �깮�꽦
        initRsa(request);
        ModelAndView mav = new ModelAndView();
        
        String message = request.getParameter("message")==null ? "" : request.getParameter("message");

        if(!message.equals(null) || !message.equals("")) {
        	mav.addObject("message", message);
        }

        mav.setViewName("/register/signIn");
        return mav;
	}
	
	@RequestMapping(value = "/loginController", method = RequestMethod.POST)
	public ModelAndView loginController(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userEmail = (String) request.getParameter("userEmail");
		String userPassword = (String) request.getParameter("userPassword");
		HashMap<String, String> hashmap = new HashMap<String, String>();
		
		HttpSession session = request.getSession();
	    
		PrivateKey privateKey = (PrivateKey) session.getAttribute(LoginController.RSA_WEB_KEY);

		// 蹂듯샇�솕
        userEmail    = decryptRsa(privateKey, userEmail);
        userPassword = decryptRsa(privateKey, userPassword);
	 
        // 媛쒖씤�궎 �궘�젣
        session.removeAttribute(LoginController.RSA_WEB_KEY);
        
        hashmap.put("userEmail", userEmail);
        hashmap.put("userPassword", userPassword);
 
        // 濡쒓렇�씤 泥섎━
        List<Map<String, Object>> list = null;
		try {
			list = loginService.loginCheck(hashmap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
        ModelAndView mv = new ModelAndView();
        
		if(list.size()>0) {
			session.setAttribute("userEmail",list.get(0).get("ID"));
			session.setAttribute("userName", list.get(0).get("NAME"));
			session.setAttribute("userAge", list.get(0).get("AGE"));
	        mv.setViewName("index");
		} else {
			mv.setViewName("redirect:loginForm.do");
			mv.addObject("message", "해당 아이디 혹은 패스워드가 존재하지 않습니다.");
		}
        return mv;
	}
	
	@RequestMapping(value = "/signUp.do", method = RequestMethod.GET)
	public ModelAndView signUpForm(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/register/signUp");
        return mav;
	}
	
	@RequestMapping(value = "/signInsert.do", method = RequestMethod.GET)
	public ModelAndView signInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        
        HashMap<String, String> hashmap = new HashMap<String, String>();
        hashmap.put("email", request.getParameter("email").toString());
        hashmap.put("password", request.getParameter("password").toString());
        hashmap.put("fullname", request.getParameter("fullname").toString());
        hashmap.put("age", request.getParameter("age").toString());
        hashmap.put("gender", request.getParameter("gender").toString());
        
		loginService.signUpForm(hashmap);
        mav.setViewName("/index");
        return mav;
	}
	
	@RequestMapping(value = "/forgotPassword.do", method = RequestMethod.GET)
	public ModelAndView forgotPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        
        HashMap<String, String> hashmap = new HashMap<String, String>();
        
        mav.setViewName("/register/forgotPassword");
        return mav;
	}
	
	@RequestMapping(value = "/mailSender.do", method = RequestMethod.POST)
	public ModelAndView mailSender(HttpServletRequest request, ModelMap mo) throws AddressException, MessagingException {
		String host = "smtp.gmail.com";
		final String username = "aixenhuh20"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요. final String password = "YYYYYYYY";
		final String password = "aixenhuh2019!";
		int port=465;
		
		String recipient = request.getParameter("passWordInputEmail").toString();
		String subject = "메일테스트"; //메일 제목 입력해주세요. 
		String randomNum = String.valueOf(((int)(Math.random()*10000)+1));
		String body = username+"님으로 부터 메일을 받았습니다. 해당 패스워드는 " + randomNum + "입니다."; //메일 내용 입력해주세요. 
		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성 
		// SMTP 서버 정보 설정 
		props.put("mail.smtp.host", host); 
		props.put("mail.smtp.port", port); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.smtp.ssl.enable", "true"); 
		props.put("mail.smtp.ssl.trust", host); 
		
		//Session 생성 
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			String un=username; 
			String pw=password; 
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
				return new javax.mail.PasswordAuthentication(un, pw); 
				} 
			}); 
			
		session.setDebug(true); 
		//for debug 
		Message mimeMessage = new MimeMessage(session); 
		//MimeMessage 생성 
		mimeMessage.setFrom(new InternetAddress("aixenhuh20@gmail.com")); 
		//발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요. 
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); 
		//수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음 
		mimeMessage.setSubject(subject); 
		//제목셋팅 
		mimeMessage.setText(body); 
		//내용셋팅 
		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
		
        HashMap<String, String> hashmap = new HashMap<String, String>();
        hashmap.put("email", recipient);
        hashmap.put("newPassWord", randomNum);
		loginService.passWordReset(hashmap);
		
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/register/forgotPassword");
        mav.addObject("message", "발송되었습니다.");
        return mav;
	}
	
	public void initRsa(HttpServletRequest request) {
		HttpSession session = request.getSession();
		 
        KeyPairGenerator generator;
        try {
            generator = KeyPairGenerator.getInstance(LoginController.RSA_INSTANCE);
            generator.initialize(1024);
 
            KeyPair keyPair = generator.genKeyPair();
            KeyFactory keyFactory = KeyFactory.getInstance(LoginController.RSA_INSTANCE);
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();
 
            session.setAttribute(LoginController.RSA_WEB_KEY, privateKey); // session�뿉 RSA 媛쒖씤�궎瑜� �꽭�뀡�뿉 ���옣
 
            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
 
            request.setAttribute("RSAModulus", publicKeyModulus); // rsa modulus 瑜� request �뿉 異붽�
            request.setAttribute("RSAExponent", publicKeyExponent); // rsa exponent 瑜� request �뿉 異붽�
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
	}

	private String decryptRsa(PrivateKey privateKey, String securedValue) {
        Cipher cipher;
        byte[] decryptedBytes;
        String decryptedValue = null;
        try {
			cipher = Cipher.getInstance(LoginController.RSA_INSTANCE);
	        byte[] encryptedBytes = hexToByteArray(securedValue);
	        cipher.init(Cipher.DECRYPT_MODE, privateKey);
	        decryptedBytes = cipher.doFinal(encryptedBytes);
	        decryptedValue = new String(decryptedBytes, "utf-8"); // 臾몄옄 �씤肄붾뵫 二쇱쓽.
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (BadPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        return decryptedValue;
	}

	public static byte[] hexToByteArray(String hex) {
	  if (hex == null || hex.length() % 2 != 0) { return new byte[] {}; }
	  
        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
	}
}
