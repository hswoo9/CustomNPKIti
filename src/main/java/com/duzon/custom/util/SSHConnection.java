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

public class SSHConnection {
	private Session session;
	
	
	
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
			
			session = jsch.getSession("ncloud", SSHhost, 10016);		//SSH 의 기본 포트는 22
			session.setPassword("3~U7s_Bmz"); //3~U7s_Bmz
			System.out.println("SSH Connection...");			
			session.setConfig("StrictHostKeyChecking", "no");

			session.connect();
			
			int forward_port = session.setPortForwardingL(3399, localhost, 13306); //127.0.0.1/  0으로 접근한 포트를 연결HOST/3306으로 포트포워딩
			System.out.println("localhost: "+forward_port+" -> "+localhost+":"+port);

			Class.forName(driver);
			conn = DriverManager.getConnection("jdbc:mariadb://"+localhost+":"+forward_port+"/cust_klti", "root", "mysql@1234");

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
