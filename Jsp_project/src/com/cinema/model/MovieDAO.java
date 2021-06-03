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

public class MovieDAO {
	Connection con = null;              // DB 연결하는 객체.
	PreparedStatement pstmt = null;     // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;                // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                  // 쿼리문을 저장할 객체.

	
	// 싱글톤 방식으로 BoardDAO 객체를 만들자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본생성자의 접근제어자를  private 으로 선언을 해야 함.
	// 2단계 : 정적 멤버로 선언을 해야 함 - static 으로 선언을 한다는 의미.
	private static MovieDAO instance = null;
	
	// 3단계 : 외부에서 객체 생성을 하지 못하게 접근을 제어 - private 기본 생성자를 만듬.
	private MovieDAO() { }
	
	// 4단계 : 기본 생성자 대신에 싱긑턴 객체를 return을 해 주는 getInstance()
	//        메서드를 만들어서 여기에 접근하게 하는 방법
	public static MovieDAO getInstance() {
		if(instance == null) {
			instance = new MovieDAO();
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
	
	public List<MovieDTO> movieOpen() {
		List<MovieDTO> list = new ArrayList<>();
		
		try {
			openConn();
			
			sql = "select * from movie order by moviecode desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieDTO dto = new MovieDTO();
				dto.setMoviecode(rs.getInt("moviecode"));
				dto.setTitle_en(rs.getString("title_en"));
				dto.setTitle_ko(rs.getString("title_ko"));
				dto.setPoster(rs.getString("poster"));
				dto.setGenre(rs.getString("genre"));
				dto.setDirector(rs.getString("director"));
				dto.setActor(rs.getString("actor"));
				dto.setSummary(rs.getString("summary"));
				dto.setRunning_time(rs.getInt("running_time"));
				dto.setAge(rs.getString("age"));
				dto.setNation(rs.getString("nation"));
				dto.setOpendate(rs.getString("opendate").substring(0,8));
				dto.setMstate(rs.getString("mstate"));
				dto.setMtype(rs.getString("mtype"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}
	
	public MovieDTO movieDetailOpen(int moviecode) {
		MovieDTO dto = new MovieDTO();
		
		try {
			openConn();
			
			sql = "select * from movie where moviecode =" + moviecode;
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setMoviecode(rs.getInt("moviecode"));
				dto.setTitle_en(rs.getString("title_en"));
				dto.setTitle_ko(rs.getString("title_ko"));
				dto.setPoster(rs.getString("poster"));
				dto.setGenre(rs.getString("genre"));
				dto.setDirector(rs.getString("director"));
				dto.setActor(rs.getString("actor"));
				dto.setSummary(rs.getString("summary"));
				dto.setRunning_time(rs.getInt("running_time"));
				dto.setAge(rs.getString("age"));
				dto.setNation(rs.getString("nation"));
				dto.setOpendate(rs.getString("opendate").substring(0,8));
				dto.setMstate(rs.getString("mstate"));
				dto.setMtype(rs.getString("mtype"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}
}
