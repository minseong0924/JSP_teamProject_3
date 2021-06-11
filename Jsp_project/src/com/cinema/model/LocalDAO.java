package com.cinema.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LocalDAO {
	
	Connection con = null;              // DB 연결하는 객체.
	PreparedStatement pstmt = null;     // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;                // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                  // 쿼리문을 저장할 객체.

	
	// 싱글톤 방식으로 BoardDAO 객체를 만들자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본생성자의 접근제어자를  private 으로 선언을 해야 함.
	// 2단계 : 정적 멤버로 선언을 해야 함 - static 으로 선언을 한다는 의미.
	private static LocalDAO instance = null;
	
	// 3단계 : 외부에서 객체 생성을 하지 못하게 접근을 제어 - private 기본 생성자를 만듬.
	private LocalDAO() { }
	
	// 4단계 : 기본 생성자 대신에 싱긑턴 객체를 return을 해 주는 getInstance()
	//        메서드를 만들어서 여기에 접근하게 하는 방법
	public static LocalDAO getInstance() {
		if(instance == null) {
			instance = new LocalDAO();
		}
		return instance;
	}  // getInstance() 메서드 end
	
	
	// DB 연동하는 작업을 진행하는 메서드 - DBCP방식으로 연결 진행
	public void openConn() {
		
		try {
			// 1단계 : JNDI 서버 객체 생성.
			Context ctx = new InitialContext();
			
			// 2단계 : lookup() 메서드를 이용하여 매칭되는 커넥션을 찾는다.
			DataSource ds = 
				(DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
			
			// 3단계 : DataSource 객체를 이용하여 커넥션 객체를 하나 가져온다.
			con = ds.getConnection();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}  // openConn() 메서드 end
	
	
	// DB에 연결된 객체를 종료하는 메서드
	public void closeConn(ResultSet rs,
			PreparedStatement pstmt, Connection con)  {
		
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	}  // closeConn() 메서드 end
	
	
	// 지역리스트 전체 검색
	public List<LocalDTO> localOpen() {
		List<LocalDTO> list = new ArrayList<>();
		
		try {
			openConn();
			
			sql = "select * from local order by localcode desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				LocalDTO dto = new LocalDTO();
				
				dto.setLocalcode(rs.getInt("localcode"));
				dto.setLocalname(rs.getString("localname"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;	
	}	// localOpen() 메서드 end
	
	// 지역리스트 전체 검색(오름차순)
	public List<LocalDTO> localOpenAsc() {
		List<LocalDTO> list = new ArrayList<>();
		
		try {
			openConn();
			
			sql = "select * from local";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				LocalDTO dto = new LocalDTO();
				
				dto.setLocalcode(rs.getInt("localcode"));
				dto.setLocalname(rs.getString("localname"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;	
	}
	
	public String LocalList() {
		String result = "";
		
		try {
			openConn();
			
			sql = "select localname, cinemaname\r\n" + 
					"from local l, cinema c \r\n" + 
					"where l.localcode = c.localcode";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			result += "<local1>";
			
			while(rs.next()) {
				result += "<local>";
				result += "<localname>" + rs.getString("localname") + "</localname>";
				result += "<cinemaname>" + rs.getString("cinemaname") + "</cinemaname>";
				result += "</local>";
			}
			result += "</local1>";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
}




