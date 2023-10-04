package com.duzon.custom.egov_cms.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.util.FilePath;
import com.duzon.custom.util.FileUtil3;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;


@Controller
public class FileController {

	private static final Logger logger = LoggerFactory.getLogger(FileController.class);

	private String defaultPath2 = "/home/neos/tomcat/webapps/CustomNPKlti/upload/";
	
	private String slash = "/";


	/**
	 * 휴가 등록 양식 다운로드
	 * @param param
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/vacationDownloadFile.do")
	public void vacationDownloadFile(@RequestParam Map<String, String> param, HttpServletResponse response, HttpServletRequest request) throws Exception {
		//String defaultPath2 = request.getSession().getServletContext().getRealPath("/upload/") + "/";
		logger.info("=" + defaultPath2);
		logger.info("=" + param.toString());
		int pathNum = param.get("pathNum") == null ? 0 : Integer.parseInt(param.get("pathNum"));
		
		String fileName = param.get("fileName") == null ? "" : param.get("fileName").toString();
		String fileMask = param.get("fileMask") == null ? "" : param.get("fileMask").toString();
		
		logger.info("============  : " + defaultPath2 + slash + pathNum);
		
		String originFilePath = FilePath.setFilePath(defaultPath2, slash, pathNum) + "original" + slash + fileMask;
		
		logger.info("============ downloadFile path : " + originFilePath);
		if (!"".equals(originFilePath) && originFilePath != null) {
			try {		
				
				byte fileByte[] = FileUtils.readFileToByteArray(new File(originFilePath));

				response.setContentType("application/octet-stream");
				response.setContentLength(fileByte.length);
				response.setHeader("Content-Disposition","attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
				response.setHeader("Content-Transfer-Encoding", "binary");
				response.getOutputStream().write(fileByte);

				response.getOutputStream().flush();
				response.getOutputStream().close();

	            
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}
}
