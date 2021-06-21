package com.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cinema.model.MovieDTO;

public class MemberDAO {
	Connection con = null;              // DB 연결하는 객체.
	PreparedStatement pstmt = null;     // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;                // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                  // 쿼리문을 저장할 객체.

	// 싱글톤 방식으로 BoardDAO 객체를 만들자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본생성자의 접근제어자를  private 으로 선언을 해야 함.
	// 2단계 : 정적 멤버로 선언을 해야 함 - static 으로 선언을 한다는 의미.
	private static MemberDAO instance = null;
	
	// 3단계 : 외부에서 객체 생성을 하지 못하게 접근을 제어 - private 기본 생성자를 만듬.
	private MemberDAO() { }
	
	// 4단계 : 기본 생성자 대신에 싱긑턴 객체를 return을 해 주는 getInstance()
	//        메서드를 만들어서 여기에 접근하게 하는 방법
	public static MemberDAO getInstance() {
		if(instance == null) {
			instance = new MemberDAO();
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
	
	public int insertMember(MemberDTO dto) {
		int result = 0;
		
		try {
			openConn();
			
				sql = "insert into member1 values(?,?,?,?,default,default,?,sysdate)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, dto.getId());
				pstmt.setString(2, dto.getPwd());
				pstmt.setString(3, dto.getName());
				pstmt.setString(4, dto.getPhone());
				pstmt.setString(5, dto.getBirth());
				
				result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;

	}
	public int memJoinIdCheck(String id) {
		int result = 0;
		
		
		try {
			openConn();
			
			sql = "Select * from member1 where id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = 1;
			}
			
			rs.close(); pstmt.close(); con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;

	}
	
	public int memberLogin(String id, String pwd) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "Select * from member1 where id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("pwd").equals(pwd)) {
					result = 1;
				} else {
					result = -1;
				}
			}
			
			rs.close(); pstmt.close(); con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public MemberSession getMember(String id, String pwd) {
		MemberSession ms = new MemberSession();
		
		try {
			openConn();
			
			sql = "Select * from member1 where id = ? and pwd = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ms.setId(rs.getString("id"));
				ms.setPwd(rs.getString("pwd"));
				ms.setName(rs.getString("name"));
				ms.setPhone(rs.getString("phone"));
				ms.setPoint(rs.getInt("point"));
				ms.setPermission(rs.getString("permission"));
				ms.setBirth(rs.getString("birth"));
				ms.setRegdate(rs.getString("regdate"));
			}
			
			rs.close(); pstmt.close(); con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return ms;
	}
	
	public String memberFindId(MemberDTO dto) {
		String findResult = "";
		
		try {
			openConn();

			sql = "Select * from member1 where name = ? and birth =? and phone =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getBirth());
			pstmt.setString(3, dto.getPhone());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				findResult = "id:"+rs.getString("id");
			} else {
				findResult = "noExist:noExist";
			}
			
			rs.close(); pstmt.close(); con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return findResult;
	}
	
	public String memberFindPwd(MemberDTO dto) {
		String findResult = "";
		
		try {
			openConn();

			sql = "Select * from member1 where name = ? and birth =? and phone =? and id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getBirth());
			pstmt.setString(3, dto.getPhone());
			pstmt.setString(4, dto.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				findResult = "pwd:"+rs.getString("pwd");
			} else {
				findResult = "noExist:noExist";
			}
			
			rs.close(); pstmt.close(); con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return findResult;
	}
	
	public int memPhoneCheck(String phone) {
		int result = 0;
		
		try {
			openConn();
			System.out.println("MemberDAO:"+phone);
			
			sql = "Select * from member1 where phone = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, phone);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = 1;
			} else {
				result = 0;
			}
			
			rs.close(); pstmt.close(); con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public MemberDTO memDetailOpen(String id) {
		MemberDTO dto = new MemberDTO();
		
		try {
			openConn();
			
			sql = "select * from member1 where id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone").replace("-", ""));
				dto.setPoint(rs.getInt("point"));
				dto.setPermission(rs.getString("permission"));
				dto.setBirth(rs.getString("birth").substring(0, 10).replace("-", ""));
				dto.setRegdate(rs.getString("regdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}
	
	
	public int memberEditOk(String id, String name, String pwd, String phone) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "update member1 set name = ?, pwd = ?, phone = ? where id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, pwd);
			pstmt.setString(3, phone);
			pstmt.setString(4, id);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public int memberDelete(String id) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from member1 where id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
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
