package com.duzon.custom.common.utiles;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 설정 파일에서 속성을 읽어오는 유틸리티 클래스
 * 시큐어 코딩 가이드라인에 따라 하드코딩된 비밀번호 대신 설정 파일에서 읽어오도록 구현
 */
public class ConfigProperties {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(ConfigProperties.class);
    private static Properties properties = new Properties();
    private static final String CONFIG_FILE = "config.properties";
    
    static {
        loadProperties();
    }
    
    /**
     * 설정 파일을 로드합니다.
     */
    private static void loadProperties() {
        try (InputStream input = new FileInputStream(System.getProperty("catalina.home") + "/conf/" + CONFIG_FILE)) {
            properties.load(input);
            LOGGER.info("설정 파일 로드 완료: {}", CONFIG_FILE);
        } catch (IOException ex) {
            LOGGER.error("설정 파일 로드 실패: {}", ex.getMessage());
            // 대체 경로에서 시도
            try (InputStream input = ConfigProperties.class.getClassLoader().getResourceAsStream(CONFIG_FILE)) {
                if (input != null) {
                    properties.load(input);
                    LOGGER.info("클래스패스에서 설정 파일 로드 완료: {}", CONFIG_FILE);
                } else {
                    LOGGER.error("클래스패스에서 설정 파일을 찾을 수 없습니다: {}", CONFIG_FILE);
                }
            } catch (IOException e) {
                LOGGER.error("클래스패스에서 설정 파일 로드 실패: {}", e.getMessage());
            }
        }
    }
    
    /**
     * 설정 파일에서 속성 값을 가져옵니다.
     * 
     * @param key 속성 키
     * @return 속성 값, 키가 없는 경우 null 반환
     */
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
    
    /**
     * 설정 파일에서 속성 값을 가져옵니다.
     * 
     * @param key 속성 키
     * @param defaultValue 기본값 (키가 없는 경우 반환)
     * @return 속성 값, 키가 없는 경우 기본값 반환
     */
    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
    
    /**
     * 설정 파일을 다시 로드합니다.
     */
    public static void reloadProperties() {
        loadProperties();
    }
}
