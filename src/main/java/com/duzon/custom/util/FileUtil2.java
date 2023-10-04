package com.duzon.custom.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class FileUtil2 {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUtil3.class);
	
	//private String slash = "\\";
	
	private String defaultFilePath;
	
	//private String defaultFilePath2 = "D:/test/";
	
	private String defaultFilePath2 = "/home/neos/tomcat/webapps/CustomNPKlti/upload/";
	
	private String[] allowType;
	
	private String slash;
	private String slash2 = "/";
	
	private long fileSize;
	
	private int thumbnailWidth;
	
	private int thumbnailHeight;
	
	public FileUtil2()  throws Exception{
		init();
	}
	
	public void init() throws Exception{
        JSch jsch = new JSch();
        try {
        	Properties properties = new Properties();
			properties.load(new FileInputStream(getClass().getClassLoader().getResource("config/properties/file.properties").getFile()));
			
			this.defaultFilePath = properties.getProperty("file.path");
			this.allowType = properties.getProperty("file.allowtype").split(",");
			this.slash = properties.getProperty("file.slash");
			this.fileSize = Long.valueOf(properties.getProperty("file.size"));
			
			this.thumbnailWidth = (properties.getProperty("thumbnail.width") == null ? 0 : Integer.parseInt(properties.getProperty("thumbnail.width")));
			this.thumbnailHeight = (properties.getProperty("thumbnail.height") == null ? 0 : Integer.parseInt(properties.getProperty("thumbnail.height")));
			
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	public boolean CompressZIP(HttpServletResponse response, Map<String, Object> params, List<Map<String, Object>> fileList) {
		String[] files = new String[fileList.size()];
		String[] originFiles = new String[fileList.size()];
		if(fileList.size() > 0) {
			for(int i = 0 ; i < fileList.size() ; i++) {
				files[i] = fileList.get(i).get("FILE_MASK").toString();
				originFiles[i] = fileList.get(i).get("saveFileName").toString();
			}
		}
		
		String[] deleteFiles = null;
		ZipOutputStream zout = null;
		//압축 파일 저장명
		String zipName = params.get("zipName").toString();
		//압축 파일 저장경로
		//String path = FilePath.setFilePath(defaultFilePath, slash, 8);
		String path = FilePath.setFilePath(defaultFilePath2, slash2, 8);
		logger.info("=============path==========="+path);
		logger.info("=============files.length==========="+files.length);
		logger.info("=============originFiles.length==========="+originFiles.length);
		File file = new File(path + "original" + slash);
		logger.info("경로있나"+file.exists());
		
		if(files.length > 0) {
			deleteFiles = new String[files.length];
			logger.info("=============files.length > 0===========");
			try {
				//zip 파일 압축 시작
				//zout = new ZipOutputStream(new FileOutputStream(path+ "original" + slash +zipName+".zip"));
				zout = new ZipOutputStream(new FileOutputStream(path+ "original" + slash2 +zipName+".zip"));
				byte[] buffer = new byte[1024];
				//byte[] buffer = new byte[4096];
				FileInputStream in = null;
				FileOutputStream out = null;
				for(int i = 0 ; i < files.length ; i++) {
					//in = new FileInputStream(path+ "original" + slash +files[i]);
					//zout.putNextEntry(new ZipEntry(files[i]));
					//한글명으로 압축 및 다운가능 근데 몇개는 어쩌다 오류가남..
					//in = new FileInputStream(path+ "original" + slash +files[i]);
					in = new FileInputStream(path+ "original" + slash2 +files[i]);
					String originFile = originFiles[i];
					deleteFiles[i] = originFile;
					//out = new FileOutputStream(path+ "original" + slash +originFile);
					out = new FileOutputStream(path+ "original" + slash2 +originFile);
					logger.info("============="+i+"===========");
					zout.putNextEntry(new ZipEntry(originFile));
					int len;
					while((len = in.read(buffer)) > 0) {
						zout.write(buffer, 0, len);
					}
					zout.closeEntry();
					in.close();
					out.close();
				}
				zout.close();
				//zip 파일 압축 끝
				
				//파일다운로드
				response.setContentType("application/octet-stream; charset=utf-8");
				response.addHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(zipName,"utf-8") +".zip");
				//FileInputStream fis = new FileInputStream(path+ "original" + slash +zipName+".zip");
				FileInputStream fis = new FileInputStream(path+ "original" + slash2 +zipName+".zip");
				BufferedInputStream bis = new BufferedInputStream(fis);
				ServletOutputStream so = response.getOutputStream();
				BufferedOutputStream bos = new BufferedOutputStream(so);
				
				int n = 0;
				while((n = bis.read(buffer)) > 0) {
					bos.write(buffer, 0, n);
					bos.flush();
				}
				if(bos != null) bos.close();
				if(bis != null) bis.close();
				if(so != null) so.close();
				if(fis != null) fis.close();
				//다운로드 끝
			}catch(Exception e) {
				return false;
			}finally {
				if(zout!=null) {
					zout = null;
				}
			}
		}
		return deleteFile(deleteFiles, 8);
		//return true;
	}
	
	public boolean deleteFile(String[] fileNames, int pathNum) {
		boolean returnFlag = true;
		
		// 파일경로
		String filePath = FilePath.setFilePath(defaultFilePath2, slash2, pathNum);;

		if(fileNames != null && fileNames.length > 0){
			for(int i = 0 ; i < fileNames.length; i++){
				File orifile = new File(filePath + "original" + slash2 + fileNames[i]);
				
				// 파일이 있는경우 삭제
				if(orifile.exists()){
					logger.info("orifile delete :[" + filePath + "original" + slash2 + fileNames[i] +"]");
					boolean deleteFlag = orifile.delete();
					logger.info("orifile deleteFlag [" + deleteFlag + "]");
					// 삭제 체크
					if(!deleteFlag){
						returnFlag = false;
						break;
					}
				}
				
			}
		}

		return returnFlag;
	}
}
