package com.cinema.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SeatDAO {
	Connection con = null;              // DB 연결하는 객체.
	PreparedStatement pstmt = null;     // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;                // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                  // 쿼리문을 저장할 객체.

	
	// 싱글톤 방식으로 BoardDAO 객체를 만들자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본생성자의 접근제어자를  private 으로 선언을 해야 함.
	// 2단계 : 정적 멤버로 선언을 해야 함 - static 으로 선언을 한다는 의미.
	private static SeatDAO instance = null;
	
	// 3단계 : 외부에서 객체 생성을 하지 못하게 접근을 제어 - private 기본 생성자를 만듬.
	private SeatDAO() { }
	
	// 4단계 : 기본 생성자 대신에 싱긑턴 객체를 return을 해 주는 getInstance()
	//        메서드를 만들어서 여기에 접근하게 하는 방법
	public static SeatDAO getInstance() {
		if(instance == null) {
			instance = new SeatDAO();
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
				e.printStackTrace();
			}
			
	}  // closeConn() 메서드 end
	
	public SeatDTO seatOpen(int cinemacode, int cincode) {
		SeatDTO dto = new SeatDTO();
		
		try {
			openConn();
			
			sql = "select * from seat where cinemacode =? and cincode =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cinemacode);
			pstmt.setInt(2, cincode);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setSeatno(rs.getInt("seatno"));
				dto.setAllseat(rs.getInt("allseat"));
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
	
	
	public int seatWrite(int allseat, int cinemacode, int cincode) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "insert into seat values((select max(seatno)+1 from seat), ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, allseat);
			pstmt.setInt(2, cinemacode);
			pstmt.setInt(3, cincode);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public int seatDetailOpen(int cinemacode, int cincode) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "select allseat from seat where cinemacode = ? and cincode = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cinemacode);
			pstmt.setInt(2, cincode);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public int seatEditOk(int allseat, int cinemacode, int cincode) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "update seat set allseat = ? where cinemacode = ? and cincode = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, allseat);
			pstmt.setInt(2, cinemacode);
			pstmt.setInt(3, cincode);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public int seatDelete(int cinemacode) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from seat where cinemacode = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cinemacode);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
}
