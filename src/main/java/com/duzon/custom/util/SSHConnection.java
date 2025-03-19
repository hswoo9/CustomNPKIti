package com.duzon.custom.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.duzon.custom.common.utiles.ConfigProperties;

public class SSHConnection {
	private Session session;
	
	// DB 드라이버
	String driver = "org.mariadb.jdbc.Driver";
	Connection conn = null;		// DB 접속 객체선언
	PreparedStatement pstmt = null;		// sql 실행할 객체 선언
	ResultSet rs = null;		// sql 실행결과를 담을 객체 선언
	

		
	String SSHhost = "211.188.69.157"; //SSH 호스트 
	String DBhost = "211.188.69.157";	//DB 호스트 
	String localhost ="127.0.0.1";	//local
	int port = 3306;	//기본 포트
	
	public SSHConnection() {
		
		try {
			JSch jsch = new JSch();
			//ssh 로 우선 접속후 port 포워딩을 통해서 mariaDB에 붙인다
			
			// 보안 취약점 수정: 하드코드된 비밀번호 제거 및 설정 파일에서 읽어오도록 변경
			String sshUser = ConfigProperties.getProperty("ssh.user", "ncloud");
			String sshPassword = ConfigProperties.getProperty("ssh.password");
			int sshPort = Integer.parseInt(ConfigProperties.getProperty("ssh.port", "10016"));
			
			session = jsch.getSession(sshUser, SSHhost, sshPort);
			session.setPassword(sshPassword);
			System.out.println("SSH Connection...");			
			session.setConfig("StrictHostKeyChecking", "no");

			session.connect();
			
			int forward_port = session.setPortForwardingL(3399, localhost, 13306); //127.0.0.1/  0으로 접근한 포트를 연결HOST/3306으로 포트포워딩
			System.out.println("localhost: "+forward_port+" -> "+localhost+":"+port);

			// DB 접속 정보도 설정 파일에서 읽어오도록 변경
			String dbUser = ConfigProperties.getProperty("db.user", "root");
			String dbPassword = ConfigProperties.getProperty("db.password");
			String dbName = ConfigProperties.getProperty("db.name", "cust_klti");
			
			Class.forName(driver);
			conn = DriverManager.getConnection("jdbc:mariadb://"+localhost+":"+forward_port+"/"+dbName, dbUser, dbPassword);

			if (conn != null) {
				System.out.println("DB 접속 성공 " + conn);

			}

		} catch (JSchException e) { 
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로드 실패");
		} catch (SQLException e) {
			System.out.println("DB 접속 실패");
			e.printStackTrace();
		}
		
	}
	
	public void closeSSH() {
		session.disconnect();
	}
	
}
