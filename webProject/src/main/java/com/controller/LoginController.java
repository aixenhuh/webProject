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

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.service.LoginService;

@Controller
public class LoginController {
    private static String RSA_WEB_KEY = "_RSA_WEB_Key_"; // 개인키 session key
    private static String RSA_INSTANCE = "RSA"; // rsa transformation
	
	@Resource(name="loginService")
	private LoginService loginService;

	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public ModelAndView loginForm(HttpServletRequest request, HttpServletResponse response) {
		// RSA 키 생성
        initRsa(request);
 
        ModelAndView mav = new ModelAndView();
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

		// 복호화
        userEmail    = decryptRsa(privateKey, userEmail);
        userPassword = decryptRsa(privateKey, userPassword);
	 
        // 개인키 삭제
        session.removeAttribute(LoginController.RSA_WEB_KEY);
        
        hashmap.put("userEmail", userEmail);
        hashmap.put("userPassword", userPassword);
 
        // 로그인 처리
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
			mv.setViewName("error");
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
 
            session.setAttribute(LoginController.RSA_WEB_KEY, privateKey); // session에 RSA 개인키를 세션에 저장
 
            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
 
            request.setAttribute("RSAModulus", publicKeyModulus); // rsa modulus 를 request 에 추가
            request.setAttribute("RSAExponent", publicKeyExponent); // rsa exponent 를 request 에 추가
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
	        decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
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
