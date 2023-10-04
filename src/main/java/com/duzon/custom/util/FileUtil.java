package com.duzon.custom.util;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


public class FileUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUtil.class);
	
	private String defaultFilePath;
	
	private String[] allowType;
	
	private String slash;
	
	private long fileSize;
	
	private int thumbnailWidth;
	
	private int thumbnailHeight;
	
	public FileUtil() {
		init();
	}
	
	public void init() {
		try {
			Properties properties = new Properties();
			properties.load(new FileInputStream(getClass().getClassLoader().getResource("config/properties/file.properties").getFile()));
			
			this.defaultFilePath = properties.getProperty("file.path");
			this.allowType = properties.getProperty("file.allowtype").split(",");
			this.slash = properties.getProperty("file.slash");
			this.fileSize = Long.valueOf(properties.getProperty("file.size"));
			
			this.thumbnailWidth = (properties.getProperty("thumbnail.width") == null ? 0 : Integer.parseInt(properties.getProperty("thumbnail.width")));
			this.thumbnailHeight = (properties.getProperty("thumbnail.height") == null ? 0 : Integer.parseInt(properties.getProperty("thumbnail.height")));
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<Map<String, Object>> storedFileInfo(HttpServletRequest request, String fileName, int pathNum, String[] boardAllowType) {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> multipartFiles = null;
		
		
		
		String originFileName = null; // 원본파일이름
		String originFileExt  = null; // 원본 파일 확장자
		String storedFileName = null; // 저장될 이름
		String fileExt        = null; // 파일확장자
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		String filePath = FilePath.setFilePath(defaultFilePath, slash, pathNum);
		
		logger.info("========= filePath : "+filePath + " =========");
		
		// 경로 생성
		File file = new File(filePath + "original" + slash);
		File thumbnailFile = new File(filePath + "thumbnail" + slash);
		
		if(!file.exists()) file.mkdir();
		if(!thumbnailFile.exists()) thumbnailFile.mkdir();
				
		try {
			
			multipartFiles = multipartRequest.getFiles(fileName);
			
			// 업로드할 파일이 있는지 체크
			if((multipartFiles != null && multipartFiles.size() > 0) && !multipartFiles.isEmpty()) {
				for(int i = 0; i < multipartFiles.size(); i++) {
					MultipartFile multipartFile = multipartFiles.get(i);
					
					boolean isUpload = false;
					
					// 파일용량 0이상만 업로드 ( 업로드사이즈 제한에 걸리지 않으면 업로드시작 )
					if(multipartFile.getSize() > 0 && (multipartFile.getSize() < fileSize)) {
						
						//originFileName = new String (multipartFile.getOriginalFilename().getBytes("8859_1"), "UTF-8");
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
                            for(String ext : allowType) {
                            	if(ext.equals(fileExt)) isUpload = true;
                            }
                        }
                        
                        logger.info("========= isUpload : "+isUpload+" ========= ");
                        
                        if(isUpload) {
                        	BufferedInputStream bi = null;
                    		storedFileName = RandomUUID.getRandomString() + originFileExt;
                    		File originStoredFile = new File(filePath + "original" + slash + storedFileName);
                    		bi = new BufferedInputStream(new URL(filePath + "original" + slash + storedFileName).openStream());
                    		int len;
                    		byte buffer[] = new byte[1024];
                    		logger.info("========= Create Original File ==========");
                    		FileOutputStream fo = new FileOutputStream(originStoredFile);
                    		while((len = bi.read(buffer, 0, buffer.length)) != -1) {
                    			fo.write(buffer, 0, len);
                    		}
                    		//multipartFile.transferTo();
                    		bi.close();
                    		fo.close();
                    		listMap = new HashMap<String, Object>();
                    		listMap.put("originFileExt", originFileExt);
                    		listMap.put("originFileName", originFileName);
                    		listMap.put("storedFileName", storedFileName);
                    		listMap.put("fileSize", multipartFile.getSize());

                    		list.add(listMap);
                    		
                    		if(imageTypeCheck(fileExt)) {
                    			logger.info("========= Create Thumbnail File ==========");
                    			// 썸네일 생성
                    			createThumbnailImage(filePath, originFileExt, originStoredFile);
                    			
                    		}
                    		
                        }
					}
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
public List<Map<String, Object>> storedFileInfoPdfToImg(HttpServletRequest request, String fileName, int pathNum, String[] boardAllowType) {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> multipartFiles = null;
		
		String originFileName = null; // 원본파일이름
		String originFileExt  = null; // 원본 파일 확장자
		String storedFileName = null; // 저장될 이름
		String fileExt        = null; // 파일확장자
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		Map<String, Object> listMap2 = null;
		
		String filePath = FilePath.setFilePath(defaultFilePath, slash, pathNum);
		
		logger.info("========= filePath : "+filePath + " =========");
		
		// 경로 생성
		File file = new File(filePath + "original" + slash);
		File thumbnailFile = new File(filePath + "thumbnail" + slash);
		
		if(!file.exists()) file.mkdir();
		if(!thumbnailFile.exists()) thumbnailFile.mkdir();
				
		try {
			
			multipartFiles = multipartRequest.getFiles(fileName);
			
			// 업로드할 파일이 있는지 체크
			if((multipartFiles != null && multipartFiles.size() > 0) && !multipartFiles.isEmpty()) {
				for(int i = 0; i < multipartFiles.size(); i++) {
					MultipartFile multipartFile = multipartFiles.get(i);
					
					boolean isUpload = false;
					
					// 파일용량 0이상만 업로드 ( 업로드사이즈 제한에 걸리지 않으면 업로드시작 )
					if(multipartFile.getSize() > 0) {
						
						//originFileName = new String (multipartFile.getOriginalFilename().getBytes("8859_1"), "UTF-8");
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
                            for(String ext : allowType) {
                            	if(ext.equals(fileExt)) isUpload = true;
                            }
                        }
                        
                        logger.info("========= isUpload : "+isUpload+" ========= ");
                        
                        if(isUpload) {
                    		
                    		storedFileName = RandomUUID.getRandomString() + originFileExt;
                    		
                    		File originStoredFile = new File(filePath + "original" + slash + storedFileName);
                    		
                    		logger.info("========= Create Original File ==========");
                    		
                    		multipartFile.transferTo(originStoredFile);
                    		
                    		
                    		
                    		///
                    		PDDocument pdfDoc = PDDocument.load(originStoredFile); //Document 생성
                            PDFRenderer pdfRenderer = new PDFRenderer(pdfDoc);
                            Files.createDirectories(Paths.get(filePath + "original" + slash)); //PDF 2 Img에서는 경로가 없는 경우 이미지 파일이 생성이 안되기 때문에 디렉토리를 만들어준다.
                            String imgFileName = null;
                          //순회하며 이미지로 변환 처리
                            //for (int j=0; j<pdfDoc.getPages().getCount(); j++) {
                        	for (int j=0; j<1; j++) {
                        		listMap2 = new HashMap<String, Object>();
                                imgFileName = filePath + "original" + slash + storedFileName + "_" + j + ".png";
                            	//DPI 설정
                                BufferedImage bim = pdfRenderer.renderImageWithDPI(j, 300, ImageType.RGB);
                                // 이미지로 만든다.
                                ImageIOUtil.writeImage(bim, imgFileName , 300);
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
	
	public boolean deleteFile(String[] fileNames, int pathNum) {
		boolean returnFlag = true;
		
		// 파일경로
		String filePath = FilePath.setFilePath(defaultFilePath, slash, pathNum);;

		if(fileNames != null && fileNames.length > 0){
			for(int i = 0 ; i < fileNames.length; i++){
				File orifile = new File(filePath + "original" + slash + fileNames[i]);
				File thumbnail = new File(filePath + "thumbnail" + slash + fileNames[i]);
				
				// 파일이 있는경우 삭제
				if(orifile.exists()){
					logger.info("orifile delete :[" + filePath + "original" + slash + fileNames[i] +"]");
					boolean deleteFlag = orifile.delete();
					logger.info("orifile deleteFlag [" + deleteFlag + "]");
					// 삭제 체크
					if(!deleteFlag){
						returnFlag = false;
						break;
					}
				}
				
				if(thumbnail.exists()){
					logger.info("thumbnail delete :[" + filePath + "thumbnail" + slash + fileNames[i] +"]");
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

		return returnFlag;
	}
	
	public boolean imageTypeCheck(String extention) {
		String [] types = { "jpg", "jpeg", "png", "gif" };
		boolean isImage = false;
		
		for(String type : types) {
			if(type.equals(extention)) isImage = true;
		}
		
		return isImage;
	}
	
	public void createThumbnailImage(String filePath, String originalFileExtention, File originalFile) {
		try {
			// 썸네일 생성
			String thumbnailPath = filePath + "thumbnail" + slash + originalFile.getName();
			File thumbnailFile = new File(thumbnailPath);
			
			double ratio = 2; // 이미지 축소 비율
			BufferedImage originImage = ImageIO.read(originalFile); // 원본이미지 
			
			int tWidth = (int)((thumbnailWidth == 0 ? originImage.getWidth() : thumbnailWidth) / ratio);   // 생성 썸네일 이미지 넓이
			int tHeight = (int)((thumbnailHeight == 0 ? originImage.getHeight() : thumbnailHeight) / ratio); // 생성 썸네일 이미지 높이
			
			BufferedImage thumbnailImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphics2d = thumbnailImage.createGraphics();
			Image image = originImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
			graphics2d.drawImage(image, 0, 0, tWidth, tHeight, null);
			graphics2d.dispose(); // 리소스 해제
			
			ImageIO.write(thumbnailImage, originalFileExtention, thumbnailFile);
			
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
}
