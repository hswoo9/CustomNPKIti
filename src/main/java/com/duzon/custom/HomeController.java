package com.duzon.custom;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.duzon.custom.common.dao.CommonDAO;

/**
 * 테스트 컨트롤입니다.
 * 개발시 삭제해주세요.
 * @author iguns
 *
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Resource(name="CommonDAO")
	CommonDAO commonDAO;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
//		System.out.println(commonDAO.selectList("login.selectLoginHistoryList", null));
		
		
		
		return "home";
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Locale locale, Model model) {
		logger.info("Welcome index! The client locale is {}.", locale);
		
		
		return "index";
	}
	
	
	@RequestMapping(value = "/jsonTest", method = RequestMethod.GET)
	public ModelAndView jsonTest(Locale locale, Model model) {
		logger.info("Welcome jsonTest! The client locale is {}.", locale);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("result", "SUCCESS");
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	@RequestMapping(value = "/fileUpload")
	public ModelAndView fileUpload(MultipartHttpServletRequest multipartHttpServletRequest) throws 
		IOException {
		
		//파일경로
		String filePath = "C:\\Upload\\";
		
		//파일들을 List형식으로 보관
		List<MultipartFile> files = multipartHttpServletRequest.getFiles("files");
		
		File file = new File(filePath);
		
		//파일이 없다면 디렉토리를 생성
		if ( file.exists() == false ) {
			file.mkdirs();
		}
		
		for ( int i = 0 ; i < files.size() ; i++ ) {
			
			System.out.println(files.get(i).getOriginalFilename() + " 업로드");
			//파일 업로드 소스 여기에 삽입
			file = new File(filePath+files.get(i).getOriginalFilename());
			files.get(i).transferTo(file);
			
			
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/home"); 
		mv.addObject("msg", "12341234");


		
		return mv; 
		
	}
	
}
