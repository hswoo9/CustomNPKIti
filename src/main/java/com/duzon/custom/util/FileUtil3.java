package com.duzon.custom.util;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
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

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
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

public class FileUtil3 {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUtil3.class);
	
	
	//private String ADDRESS = "1.233.95.140";
	private String ADDRESS = "211.199.189.176";
	//private int PORT = 34555;
	private int PORT = 20022;
	private String USERNAME = "root";
	//private String PASSWORD = "epqmwlttn1q2w3e";
	private String PASSWORD = "siwon12!@";
	private static Session session = null;
	private static Channel channel = null;
	private static ChannelSftp channelSftp = null;
	
	//private String slash = "\\";
	
	private String defaultFilePath;
	private String defaultFilePath2 = "/home/neos/tomcat/webapps/CustomNPKlti/upload/";
	//private String defaultFilePath2 = "D:/test/";
	
	private String[] allowType;
	
	private String slash;
	private String slash2 = "/";
	
	private long fileSize;
	
	private int thumbnailWidth;
	
	private int thumbnailHeight;
	
	public FileUtil3()  throws Exception{
		init();
	}
	
	/**
     * 서버와 연결에 필요한 값들을 가져와 초기화 시킴
     *
     * @param ADDRESS
     *            서버 주소
     * @param USERNAME
     *            접속에 사용될 아이디
     * @param PASSWORD
     *            비밀번호
     * @param PORT
     *            포트번호
	 * @throws IOException 
	 * @throws FileNotFoundException 
     */
    public void init() throws Exception{
        JSch jsch = new JSch();
        try {
        	logger.info("		init()		");
        	
        	Properties properties = new Properties();
			properties.load(new FileInputStream(getClass().getClassLoader().getResource("config/properties/file.properties").getFile()));
			
			this.defaultFilePath = properties.getProperty("file.path");
			this.allowType = properties.getProperty("file.allowtype").split(",");
			this.slash = properties.getProperty("file.slash");
			this.fileSize = Long.valueOf(properties.getProperty("file.size"));
			
			this.thumbnailWidth = (properties.getProperty("thumbnail.width") == null ? 0 : Integer.parseInt(properties.getProperty("thumbnail.width")));
			this.thumbnailHeight = (properties.getProperty("thumbnail.height") == null ? 0 : Integer.parseInt(properties.getProperty("thumbnail.height")));
			
			
			
            session = jsch.getSession(USERNAME, ADDRESS, PORT);
            session.setPassword(PASSWORD);
 
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            session.connect();
            channel = session.openChannel("sftp");
            channel.connect();
        } catch (JSchException e) {
            e.printStackTrace();
        }
        channelSftp = (ChannelSftp) channel;
 
    }
 
    /**
     * 단일 파일을 업로드
     *
     * @param dir
     *            저장시킬 주소(서버)
     * @param file
     *            저장할 파일 경로
     */
    public List<Map<String, Object>> upload(HttpServletRequest request, String fileName, int pathNum, String[] boardAllowType) {
    	
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> multipartFiles = null;
		
		
		
		String originFileName = null; // 원본파일이름
		String originFileExt  = null; // 원본 파일 확장자
		String storedFileName = null; // 저장될 이름
		String fileExt        = null; // 파일확장자
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		//String filePath = FilePath.setFilePath("/root/apache-tomcat-7.0.99/webapps/ROOT/upload/", slash2, pathNum);
		String filePath = FilePath.setFilePath("/usr/local/apache-tomcat-7.0.109/webapps/cms_jif/upload/", slash2, pathNum);
		String filePath2 = FilePath.setFilePath(defaultFilePath2, slash2, pathNum);
		logger.info("				filePath					"+filePath.toString());
		logger.info("				filePath2					"+filePath2.toString());
		// 경로 생성
		File file = new File(filePath2 + "original" + slash2);
		
		if(!file.exists()) file.mkdir();
        try {
        	
        	multipartFiles = multipartRequest.getFiles(fileName);
        	if((multipartFiles != null && multipartFiles.size() > 0) && !multipartFiles.isEmpty()) {
				for(int i = 0; i < multipartFiles.size(); i++) {
					MultipartFile multipartFile = multipartFiles.get(i);
					logger.info("				multipartFiles.size()					"+multipartFiles.size()+"	multipartFile.getName()		"+multipartFile.getOriginalFilename()+"	[ "+multipartFile.toString());
					boolean isUpload = true;
					// 파일용량 0이상만 업로드 ( 업로드사이즈 제한에 걸리지 않으면 업로드시작 )
					if(multipartFile.getSize() > 0) {
						logger.info("				multipartFile					");
						originFileName = multipartFile.getOriginalFilename();
                        originFileExt = originFileName.substring(originFileName.lastIndexOf("."));
                        fileExt = originFileName.substring(originFileName.lastIndexOf(".") + 1, originFileName.length());
                        fileExt = fileExt.toLowerCase();
                        // 업로드 허용 확장자 검사 ( 게시판 업로드 허용 확장자를 넘겨준경우는 게시판 등록 기준으로 검사 함 )
                        if(boardAllowType != null && boardAllowType.length > 0) {
                        	for(String ext : boardAllowType) {
                            	if(ext.equals(fileExt)) isUpload = true;
                            }
                        }
                        
                        if(isUpload) {
                    		storedFileName = RandomUUID.getRandomString() + originFileExt;
                    		File originStoredFile = new File(filePath2 + "original" + slash2 + storedFileName);
                    		multipartFile.transferTo(originStoredFile);
                    		FileInputStream in = new FileInputStream(originStoredFile);
                            channelSftp.cd(filePath.replace("\\\\", "/").replace("\\", "/")+"/original/");
                            channelSftp.put(in, storedFileName);
                            in.close();
                    		listMap = new HashMap<String, Object>();
                    		listMap.put("originFileExt", originFileExt);
                    		listMap.put("originFileName", originFileName);
                    		listMap.put("storedFileName", storedFileName);
                    		listMap.put("fileSize", multipartFile.getSize());
                    		list.add(listMap);
                    		
                        }
					}
				}
        	}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
 
    
    /**
     * 단일 파일을 업로드
     *
     * @param dir
     *            저장시킬 주소(서버)
     * @param file
     *            저장할 파일 경로
     */
    public List<Map<String, Object>> upload2(HttpServletRequest request, String fileName, int pathNum, String[] boardAllowType, String vcatnUseHistSn) {
    	this.defaultFilePath2 = request.getSession().getServletContext().getRealPath("/upload/") + slash2;
    	
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> multipartFiles = null;
		
		
		String originFileName = null; // 원본파일이름
		String originFileExt  = null; // 원본 파일 확장자
		String storedFileName = null; // 저장될 이름
		String fileExt        = null; // 파일확장자
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		String filePath2 = FilePath.setFilePath(defaultFilePath2, slash2, pathNum);
		logger.info("				filePath2					"+filePath2.toString());
		// 경로 생성
		File file = new File(filePath2 + "original" + slash2);
		
		if(!file.exists()) file.mkdir();
        try {
        	
        	multipartFiles = multipartRequest.getFiles(fileName);
        	if((multipartFiles != null && multipartFiles.size() > 0) && !multipartFiles.isEmpty()) {
				for(int i = 0; i < multipartFiles.size(); i++) {
					MultipartFile multipartFile = multipartFiles.get(i);
					logger.info("				multipartFiles.size()					"+multipartFiles.size()+"	multipartFile.getName()		"+multipartFile.getOriginalFilename()+"	[ "+multipartFile.toString());
					boolean isUpload = true;
					// 파일용량 0이상만 업로드 ( 업로드사이즈 제한에 걸리지 않으면 업로드시작 )
					if(multipartFile.getSize() > 0) {
						logger.info("				multipartFile					");
						originFileName = multipartFile.getOriginalFilename();
                        originFileExt = originFileName.substring(originFileName.lastIndexOf("."));
                        fileExt = originFileName.substring(originFileName.lastIndexOf(".") + 1, originFileName.length());
                        fileExt = fileExt.toLowerCase();
                        // 업로드 허용 확장자 검사 ( 게시판 업로드 허용 확장자를 넘겨준경우는 게시판 등록 기준으로 검사 함 )
                        if(boardAllowType != null && boardAllowType.length > 0) {
                        	for(String ext : boardAllowType) {
                            	if(ext.equals(fileExt)) isUpload = true;
                            }
                        }
                        
                        if(isUpload) {
                    		storedFileName = RandomUUID.getRandomString() + originFileExt;
                    		File originStoredFile = new File(filePath2 + "original" + slash2 + storedFileName);
                    		multipartFile.transferTo(originStoredFile);
                    		listMap = new HashMap<String, Object>();
                    		listMap.put("vcatnUseHistSn", vcatnUseHistSn);
                    		listMap.put("fileExtention", originFileExt);
                    		listMap.put("fileName", originFileName);
                    		listMap.put("fileMask", storedFileName);
                    		listMap.put("fileSize", multipartFile.getSize());
                    		list.add(listMap);
                    		
                        }
					}
				}
        	}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    /**
     * 단일 파일 다운로드
     *
     * @param dir
     *            저장할 경로(서버)
     * @param downloadFileName
     *            다운로드할 파일
     * @param path
     *            저장될 공간
     */
    public void download(String dir, String downloadFileName, String path) {
        InputStream in = null;
        FileOutputStream out = null;
        try {
            channelSftp.cd(dir);
            in = channelSftp.get(downloadFileName);
        } catch (SftpException e) {
            e.printStackTrace();
        }
 
        try {
            out = new FileOutputStream(new File(path));
            int i;
 
            while ((i = in.read()) != -1) {
                out.write(i);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                out.close();
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
 
        }
 
    }
 
    /**
     * 서버와의 연결을 끊는다.
     */
    public void disconnection() {
        channelSftp.quit();
 
    }
    
    /**
     * 압축 파일용 파일 삭제
     */
    public boolean deleteFileZIP(String[] fileNames, int pathNum) throws SftpException {
		boolean returnFlag = true;
		
		// 파일경로
		//String filePath = FilePath.setFilePath("/root/apache-tomcat-7.0.99/webapps/ROOT/upload/", slash2, pathNum);
		String filePath = FilePath.setFilePath("/usr/local/apache-tomcat-7.0.109/webapps/cms_jif/upload/", slash2, pathNum);
		String filePath2 = FilePath.setFilePath(defaultFilePath2, slash2, pathNum);

		if(fileNames != null && fileNames.length > 0){
			for(int i = 0 ; i < fileNames.length; i++){
				File orifile = new File(filePath + "original" + slash2 + fileNames[i]);
				File orifile2 = new File(filePath2 + "original" + slash2 + fileNames[i]);
				File thumbnail = new File(filePath + "thumbnail" + slash2 + fileNames[i]);
				
				// 파일이 있는경우 삭제
				if(orifile2.exists()){
					logger.info("orifile delete :[" + filePath + "original" + slash2 + fileNames[i] +"]");
					boolean deleteFlag = orifile2.delete();
					//channelSftp.rm(fileNames[i]);
					logger.info("orifile deleteFlag [" + deleteFlag + "]");
					// 삭제 체크
					if(!deleteFlag){
						returnFlag = false;
						break;
					}
				}
				
				if(thumbnail.exists()){
					logger.info("thumbnail delete :[" + filePath + "thumbnail" + slash2 + fileNames[i] +"]");
					boolean deleteFlag = thumbnail.delete();
					logger.info("thumbnail deleteFlag [" + deleteFlag + "]");
					// 삭제 체크
					if(!deleteFlag){
						returnFlag = false;
						break;
					}
				}
			}
		}
		disconnection();
		return returnFlag;
	}
    
    /**
     * 파일 삭제
     */
    public boolean deleteFile(String[] fileNames, int pathNum) throws SftpException {
		boolean returnFlag = true;
		
		// 파일경로
		//String filePath = FilePath.setFilePath("/root/apache-tomcat-7.0.99/webapps/ROOT/upload/", slash2, pathNum);
		String filePath = FilePath.setFilePath("/usr/local/apache-tomcat-7.0.109/webapps/cms_jif/upload/", slash2, pathNum);
		String filePath2 = FilePath.setFilePath(defaultFilePath2, slash2, pathNum);

		if(fileNames != null && fileNames.length > 0){
			for(int i = 0 ; i < fileNames.length; i++){
				File orifile = new File(filePath + "original" + slash2 + fileNames[i]);
				File orifile2 = new File(filePath2 + "original" + slash2 + fileNames[i]);
				File thumbnail = new File(filePath + "thumbnail" + slash2 + fileNames[i]);
				
				// 파일이 있는경우 삭제
				if(orifile2.exists()){
					logger.info("orifile delete :[" + filePath + "original" + slash2 + fileNames[i] +"]");
					boolean deleteFlag = orifile2.delete();
					channelSftp.cd(filePath.replace("\\\\", "/").replace("\\", "/")+"/original/");
					channelSftp.rm(fileNames[i]);
					logger.info("orifile deleteFlag [" + deleteFlag + "]");
					// 삭제 체크
					if(!deleteFlag){
						returnFlag = false;
						break;
					}
				}
				
				if(thumbnail.exists()){
					logger.info("thumbnail delete :[" + filePath + "thumbnail" + slash2 + fileNames[i] +"]");
					boolean deleteFlag = thumbnail.delete();
					logger.info("thumbnail deleteFlag [" + deleteFlag + "]");
					// 삭제 체크
					if(!deleteFlag){
						returnFlag = false;
						break;
					}
				}
			}
		}
		//disconnection();
		return returnFlag;
	}
    
    /**
     * PDF 업로드 시 이미지 추출 
     * @throws SftpException
     */
    public List<Map<String, Object>> storedFileInfoPdfToImg(HttpServletRequest request, String fileName, int pathNum, String[] boardAllowType) throws SftpException {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> multipartFiles = null;
		
		String originFileName = null; // 원본파일이름
		String originFileExt  = null; // 원본 파일 확장자
		String storedFileName = null; // 저장될 이름
		String fileExt        = null; // 파일확장자
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		Map<String, Object> listMap2 = null;
		
		//String filePath = FilePath.setFilePath("/root/apache-tomcat-7.0.99/webapps/ROOT/upload/", slash2, pathNum);
		String filePath = FilePath.setFilePath("/usr/local/apache-tomcat-7.0.109/webapps/cms_jif/upload/", slash2, pathNum);
		String filePath2 = FilePath.setFilePath(defaultFilePath2, slash2, pathNum);
		
		logger.info("========= filePath : "+filePath + " =========");
		
		// 경로 생성
		File file = new File(filePath2 + "original" + slash2);
		
		if(!file.exists()) file.mkdir();
				
		try {
			
			multipartFiles = multipartRequest.getFiles(fileName);
			
			// 업로드할 파일이 있는지 체크
			if((multipartFiles != null && multipartFiles.size() > 0) && !multipartFiles.isEmpty()) {
				for(int i = 0; i < multipartFiles.size(); i++) {
					MultipartFile multipartFile = multipartFiles.get(i);
					
					boolean isUpload = false;
					
					// 파일용량 0이상만 업로드 ( 업로드사이즈 제한에 걸리지 않으면 업로드시작 )
					if(multipartFile.getSize() > 0) {
						
						originFileName = multipartFile.getOriginalFilename();
                        originFileExt = originFileName.substring(originFileName.lastIndexOf("."));
                        logger.info("========= originFileName : "+originFileName + "========= ");
                        fileExt = originFileName.substring(originFileName.lastIndexOf(".") + 1, originFileName.length());
                        fileExt = fileExt.toLowerCase();
                        logger.info("========= fileExt : "+fileExt + "========= ");
                        
                        
                        // 업로드 허용 확장자 검사 ( 게시판 업로드 허용 확장자를 넘겨준경우는 게시판 등록 기준으로 검사 함 )
                        if(boardAllowType != null && boardAllowType.length > 0) {
                        	for(String ext : boardAllowType) {
                            	if(ext.equals(fileExt)) isUpload = true;
                            }
                        } else {
                        	if("pdf".equals(fileExt)) isUpload = true;
                        }
                        
                        logger.info("========= isUpload : "+isUpload+" ========= ");
                        
                        if(isUpload) {
                    		
                    		storedFileName = RandomUUID.getRandomString() + originFileExt;
                    		File originStoredFile = new File(filePath2 + "original" + slash2 + storedFileName);
                    		logger.info("========= Create Original File ==========");
                    		multipartFile.transferTo(originStoredFile);
                    		FileInputStream in = new FileInputStream(originStoredFile);
                    		channelSftp.cd(filePath.replace("\\\\", "/").replace("\\", "/")+"/original/");
                            channelSftp.put(in, storedFileName);
                    		
                    		in.close();
                    		///
                    		PDDocument pdfDoc = PDDocument.load(originStoredFile); //Document 생성
                            PDFRenderer pdfRenderer = new PDFRenderer(pdfDoc);
                            Files.createDirectories(Paths.get(filePath2 + "original" + slash2)); //PDF 2 Img에서는 경로가 없는 경우 이미지 파일이 생성이 안되기 때문에 디렉토리를 만들어준다.
                            String imgFileName = null;
                          //순회하며 이미지로 변환 처리
                            //for (int j=0; j<pdfDoc.getPages().getCount(); j++) {
                        	for (int j=0; j<1; j++) {
                        		listMap2 = new HashMap<String, Object>();
                                imgFileName = filePath2 + "original" + slash2 + storedFileName + "_" + j + ".png";
                                String imgSaveName = storedFileName + "_" + j + ".png";
                            	//DPI 설정
                                BufferedImage bim = pdfRenderer.renderImageWithDPI(j, 300, ImageType.RGB);
                                // 이미지로 만든다.
                                ImageIOUtil.writeImage(bim, imgFileName , 300);
                                
                                FileInputStream in2 = new FileInputStream(imgFileName);
                        		channelSftp.cd(filePath.replace("\\\\", "/").replace("\\", "/")+"/original/");
                                channelSftp.put(in2, imgSaveName);
                                
                                
                                //저장 완료된 이미지를 list에 추가한다.
                                listMap2.put("originFileExt", ".png");
                        		listMap2.put("originFileName", "viewPdf");
                        		listMap2.put("storedFileName", storedFileName + "_" + j + ".png");
                                
                            }
                            
                    		///
                    		
                            pdfDoc.close(); //모두 사용한 PDF 문서는 닫는다
                    		
                    		listMap = new HashMap<String, Object>();
                    		listMap.put("originFileExt", originFileExt);
                    		listMap.put("originFileName", originFileName);
                    		listMap.put("storedFileName", storedFileName);
                    		listMap.put("fileSize", multipartFile.getSize());
                    		listMap.put("imgMap",listMap2);
                    		list.add(listMap);
                        }
					}
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return list;
	}
    
    /**
     * 압축 다운로드 
     * @throws SftpException
     */
    public boolean CompressZIP(HttpServletRequest request, HttpServletResponse response, String filePath, Map<String, Object> fileMap) throws SftpException {
		String[] files = fileMap.get("FILE_MASK").toString().split(",");
		String[] originFiles = fileMap.get("FILE_NAME").toString().split(",");
		String[] deleteFiles = null;
		ZipOutputStream zout = null;
		//압축 파일 저장명
		String zipName = fileMap.get("zipName").toString();
		
		//압축 파일 저장경로
		String filePath1 = FilePath.setFilePath(defaultFilePath2, slash2, 6);
		//String filePath2 = FilePath.setFilePath("/root/apache-tomcat-7.0.99/webapps/ROOT/upload/", slash2, 6);
		String filePath2 = FilePath.setFilePath("/usr/local/apache-tomcat-7.0.109/webapps/cms_jif/upload/", slash2, 6);
		//경로 생성
		File file = new File(filePath1 + "original" + slash2);
		if(!file.exists()) file.mkdir();
		//channelSftp.mkdir(filePath2.replace("\\\\", "/").replace("\\", "/")+"/original/");
		logger.info("=============files.length==========="+files.length);
		logger.info("=============originFiles.length==========="+originFiles.length);
		
		if(files.length > 0) {
			deleteFiles = new String[files.length];
			logger.info("=============files.length > 0===========");
			try {
				//로컬에 알집 파일 생성
				zout = new ZipOutputStream(new FileOutputStream(filePath1+ "original" + slash2 +zipName+".zip"));
				byte[] buffer = new byte[1024];
				//byte[] buffer = new byte[4096];
				InputStream in = null;
				FileOutputStream out = null;
				logger.info("								for 문 바로 위 											");
				for(int i = 0 ; i < files.length ; i++) {
					//in = new FileInputStream(path+ "original" + slash +files[i]);
					//zout.putNextEntry(new ZipEntry(files[i]));
					//한글명으로 압축 및 다운가능 근데 몇개는 어쩌다 오류가남..
					//in = new FileInputStream(path+ "original" + slash +files[i]);
					//경로 이동
					channelSftp.cd(filePath2.replace("\\\\", "/").replace("\\", "/")+"/original/");
					logger.info("												"+files[i].toString());
					in = channelSftp.get(files[i]);
					logger.info("					in = (FileInputStream) channelSftp.get(files[i]);							");
					String originFile = "file"+i+"_"+originFiles[i];
					deleteFiles[i] = originFile;
					//out = new FileOutputStream(path+ "original" + slash +originFile);
					logger.info("============="+i+"===========");
					zout.putNextEntry(new ZipEntry(originFile));
					int len;
					while((len = in.read(buffer)) > 0) {
						zout.write(buffer, 0, len);
					}
					zout.closeEntry();
					in.close();
					//out.close();
				}
				zout.close();
				//zip 파일 압축 끝
				
				//파일다운로드
				response.setContentType("application/octet-stream; charset=utf-8");
				response.addHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(zipName,"utf-8") +".zip");
				FileInputStream fis = new FileInputStream(filePath1+ "original" + slash2 +zipName+".zip");
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
		return deleteFileZIP(deleteFiles, 6);
		//return true;
	}
    
    
    public File uploadCkeditor(HttpServletRequest request, String fileName, int pathNum, String[] boardAllowType) {
    	
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> multipartFiles = null;
		
		
		
		String originFileName = null; // 원본파일이름
		String originFileExt  = null; // 원본 파일 확장자
		String storedFileName = null; // 저장될 이름
		String fileExt        = null; // 파일확장자
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		//String filePath = FilePath.setFilePath("/root/apache-tomcat-7.0.99/webapps/ROOT/upload/", slash2, pathNum);
		String filePath = FilePath.setFilePath("/usr/local/apache-tomcat-7.0.109/webapps/cms_jif/upload/", slash2, pathNum);
		String filePath2 = FilePath.setFilePath(defaultFilePath, slash, pathNum);
		logger.info("				filePath					"+filePath.toString());
		// 경로 생성
		File file = new File(filePath2 + "original" + slash);
		
		if(!file.exists()) file.mkdir();
        try {
        	
        	multipartFiles = multipartRequest.getFiles(fileName);
        	if((multipartFiles != null && multipartFiles.size() > 0) && !multipartFiles.isEmpty()) {
				for(int i = 0; i < multipartFiles.size(); i++) {
					MultipartFile multipartFile = multipartFiles.get(i);
					logger.info("				multipartFiles.size()					"+multipartFiles.size());
					boolean isUpload = true;
					// 파일용량 0이상만 업로드 ( 업로드사이즈 제한에 걸리지 않으면 업로드시작 )
					if(multipartFile.getSize() > 0) {
						logger.info("				multipartFile					");
						originFileName = multipartFile.getOriginalFilename();
                        originFileExt = originFileName.substring(originFileName.lastIndexOf("."));
                        fileExt = originFileName.substring(originFileName.lastIndexOf(".") + 1, originFileName.length());
                        fileExt = fileExt.toLowerCase();
                        // 업로드 허용 확장자 검사 ( 게시판 업로드 허용 확장자를 넘겨준경우는 게시판 등록 기준으로 검사 함 )
                        if(boardAllowType != null && boardAllowType.length > 0) {
                        	for(String ext : boardAllowType) {
                            	if(ext.equals(fileExt)) isUpload = true;
                            }
                        }
                        
                        if(isUpload) {
                    		storedFileName = RandomUUID.getRandomString() + originFileExt;
                    		File originStoredFile = new File(filePath2 + "original" + slash + storedFileName);
                    		multipartFile.transferTo(originStoredFile);
                    		FileInputStream in = new FileInputStream(originStoredFile);
                            channelSftp.cd(filePath.replace("\\\\", "/").replace("\\", "/")+"/original/");
                            channelSftp.put(in, originStoredFile.getName());
                            in.close();
                    		
                        }
					}
				}
        	}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return file;
    }
}
