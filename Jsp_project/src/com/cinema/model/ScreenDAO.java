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

public class ScreenDAO {
	Connection con = null;              // DB 연결하는 객체.
	PreparedStatement pstmt = null;     // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;                // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                  // 쿼리문을 저장할 객체.

	
	// 싱글톤 방식으로 BoardDAO 객체를 만들자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본생성자의 접근제어자를  private 으로 선언을 해야 함.
	// 2단계 : 정적 멤버로 선언을 해야 함 - static 으로 선언을 한다는 의미.
	private static ScreenDAO instance = null;
	
	// 3단계 : 외부에서 객체 생성을 하지 못하게 접근을 제어 - private 기본 생성자를 만듬.
	private ScreenDAO() { }
	
	// 4단계 : 기본 생성자 대신에 싱긑턴 객체를 return을 해 주는 getInstance()
	//        메서드를 만들어서 여기에 접근하게 하는 방법
	public static ScreenDAO getInstance() {
		if(instance == null) {
			instance = new ScreenDAO();
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
	
	public int insertScreen(ScreenDTO dto) {
		int result = 0, count = 11111;
		
		try {
			openConn();
			
			sql = "select max(screencode) from screen";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getInt(1) != 0) {
 					count = rs.getInt(1) + 1;
				}
			}
			
			sql = "select * from screen where cinemacode = ? "+ 
					"and cincode = ? " +
					"and (? between start_time and end_time "+
					"or ? between start_time and end_time)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCinemacode());
			pstmt.setInt(2, dto.getCincode());
			pstmt.setInt(3, dto.getStart_time());
			pstmt.setInt(4, dto.getEnd_time());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = -2;
			} else {
			
				sql = "insert into screen "
						+ " values(?,?,?,?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, count);
				pstmt.setInt(2, dto.getMoviecode());
				pstmt.setInt(3, dto.getCinemacode());
				pstmt.setInt(4, dto.getCincode());
				pstmt.setInt(5, dto.getStart_time());
				pstmt.setInt(6, dto.getEnd_time());
				
				result = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	}
	
	public List<ScreenDTO> screenOpen() {
		List<ScreenDTO> list = new ArrayList<>();
		
		try {
			openConn();
			
			sql = "select * from screen order by screencode desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreenDTO dto = new ScreenDTO();
				dto.setScreencode(rs.getInt("screencode"));
				dto.setMoviecode(rs.getInt("moviecode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCincode(rs.getInt("cincode"));
				dto.setStart_time(rs.getInt("start_time"));
				dto.setEnd_time(rs.getInt("end_time"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	}
	
	public ScreenDTO screenDetailOpen(int screencode) {
		ScreenDTO dto = new ScreenDTO();
		
		try {
			openConn();
			
			sql = "select * from screen where screencode =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, screencode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setScreencode(screencode);
				dto.setMoviecode(rs.getInt("moviecode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCincode(rs.getInt("cincode"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
		
	}
	
	public int deleteScreen(int screencode) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from screen where screencode = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, screencode);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
	public int updateScreen(ScreenDTO dto) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from screen where screencode != ? "+
					"and cinemacode = ? "+ 
					"and cincode = ? " +
					"and ( ? between start_time and end_time "+
					"or ? between start_time and end_time)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getScreencode());
			pstmt.setInt(2, dto.getCinemacode());
			pstmt.setInt(3, dto.getCincode());
			pstmt.setInt(4, dto.getStart_time());
			pstmt.setInt(5, dto.getEnd_time());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = -2;
			} else {
			
				sql = "update screen set " + 
						"start_time = ?, " + 
						"end_time = ? " + 
						"where screencode = ? ";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, dto.getStart_time());
				pstmt.setInt(2, dto.getEnd_time());
				pstmt.setInt(3, dto.getScreencode());
				
				result = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
		
	}
	
}
