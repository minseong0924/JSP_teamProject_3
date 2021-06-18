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

public class CinemaDAO {
	Connection con = null;              // DB 연결하는 객체.
	PreparedStatement pstmt = null;     // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;                // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                  // 쿼리문을 저장할 객체.

	
	// 싱글톤 방식으로 BoardDAO 객체를 만들자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본생성자의 접근제어자를  private 으로 선언을 해야 함.
	// 2단계 : 정적 멤버로 선언을 해야 함 - static 으로 선언을 한다는 의미.
	private static CinemaDAO instance = null;
	
	// 3단계 : 외부에서 객체 생성을 하지 못하게 접근을 제어 - private 기본 생성자를 만듬.
	private CinemaDAO() { }
	
	// 4단계 : 기본 생성자 대신에 싱긑턴 객체를 return을 해 주는 getInstance()
	//        메서드를 만들어서 여기에 접근하게 하는 방법
	public static CinemaDAO getInstance() {
		if(instance == null) {
			instance = new CinemaDAO();
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
	
	
	public List<CinemaDTO> cinemaOpen() {
		List<CinemaDTO> list = new ArrayList<>();
		
		try {
			openConn();
			
			sql = "select * from cinema";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CinemaDTO dto = new CinemaDTO();
				dto.setLocalcode(rs.getInt("localcode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCinemaname(rs.getString("cinemaname"));
				dto.setIntro(rs.getString("intro"));
				dto.setAddress(rs.getString("address"));
				dto.setOne_cin(rs.getInt("one_cin"));
				dto.setTwo_cin(rs.getInt("two_cin"));
				dto.setThree_cin(rs.getInt("three_cin"));
				dto.setFour_cin(rs.getInt("four_cin"));
				dto.setFive_cin(rs.getInt("five_cin"));
				dto.setSix_cin(rs.getInt("six_cin"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}
	
	
	public int cinemaWriteOk(CinemaDTO dto) {
		int result = 0, count = 0;
		
		try {
			openConn();
			
			sql = "select count(*) from cinema";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into cinema values(?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getLocalcode());
			pstmt.setInt(2, count);
			pstmt.setString(3, dto.getCinemaname());
			pstmt.setString(4, dto.getIntro());
			pstmt.setString(5, dto.getAddress());
			pstmt.setInt(6, dto.getOne_cin());
			pstmt.setInt(7, dto.getTwo_cin());
			pstmt.setInt(8, dto.getThree_cin());
			pstmt.setInt(9, dto.getFour_cin());
			pstmt.setInt(10, dto.getFive_cin());
			pstmt.setInt(11, dto.getSix_cin());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public List<CinemaDTO> cinemaSearch(int code) {
		List<CinemaDTO> list = new ArrayList<>();
		
		try {
			openConn();
		
			sql = "select * from "
					+ " (select row_number() "
					+ " over(order by cinemacode) rnum, "
					+ " b.*  from cinema b where localcode like ?)";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, code);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CinemaDTO dto = new CinemaDTO();
				
				dto.setLocalcode(rs.getInt("localcode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCinemaname(rs.getString("cinemaname"));
				dto.setIntro(rs.getString("intro"));
				dto.setAddress(rs.getString("address"));
				dto.setOne_cin(rs.getInt("one_cin"));
				dto.setTwo_cin(rs.getInt("two_cin"));
				dto.setThree_cin(rs.getInt("three_cin"));
				dto.setFour_cin(rs.getInt("four_cin"));
				dto.setFive_cin(rs.getInt("five_cin"));
				dto.setSix_cin(rs.getInt("six_cin"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}
	
	
	// cinemacode가 ?인 지점 정보를 가져오는 메서드
	public CinemaDTO cinemaDetailOpen(int cinemacode) {
		CinemaDTO dto = new CinemaDTO();
		
		try {
			openConn();
			
			sql = "select * from cinema where cinemacode =" + cinemacode;
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setLocalcode(rs.getInt("localcode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCinemaname(rs.getString("cinemaname"));
				dto.setIntro(rs.getString("intro"));
				dto.setAddress(rs.getString("address"));
				dto.setOne_cin(rs.getInt("one_cin"));
				dto.setTwo_cin(rs.getInt("two_cin"));
				dto.setThree_cin(rs.getInt("three_cin"));
				dto.setFour_cin(rs.getInt("four_cin"));
				dto.setFive_cin(rs.getInt("five_cin"));
				dto.setSix_cin(rs.getInt("six_cin"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}
	
	
	public int cinemaEditOk(CinemaDTO dto) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "update cinema set localcode=?, cinemaname=?, intro=?, address=?,"
					+ "one_cin=?, two_cin=?, three_cin=?, four_cin=?, five_cin=?, six_cin=?"
					+ "where cinemacode=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getLocalcode());
			pstmt.setString(2, dto.getCinemaname());
			pstmt.setString(3, dto.getIntro());
			pstmt.setString(4, dto.getAddress());
			pstmt.setInt(5, dto.getOne_cin());
			pstmt.setInt(6, dto.getTwo_cin());
			pstmt.setInt(7, dto.getThree_cin());
			pstmt.setInt(8, dto.getFour_cin());
			pstmt.setInt(9, dto.getFive_cin());
			pstmt.setInt(10, dto.getSix_cin());
			pstmt.setInt(11, dto.getCinemacode());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	// 지점을 삭제하는 메서드
	public int cinemaDelete(int code) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from cinema where cinemacode = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, code);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public String LocalCinemaList(String local) {
		String result = "";
		int localcode = 0;
		
		try {
			openConn();
			
			sql = "select localcode from local where localname = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, local);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				localcode = rs.getInt(1);
			}
			
			sql = "select cinemaname from cinema where localcode =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, localcode);
			
			rs = pstmt.executeQuery();
			
			result += "<cin>";
			while(rs.next()) {
			result += "<cin1>";
			result += "<cinemaname>" + rs.getString("cinemaname")+"</cinemaname>";
			result += "</cin1>";
			}
			
			result += "</cin>";
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public int cinemaGetCode(String cinema_name) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "select cinemacode from cinema where cinemaname = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cinema_name);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
}