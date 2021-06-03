package com.admin.model;

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
import com.member.model.MemberDTO;

public class AdminDAO {
	Connection con = null;              // DB 연결하는 객체.
	PreparedStatement pstmt = null;     // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;                // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                  // 쿼리문을 저장할 객체.

	// 싱글톤 방식으로 BoardDAO 객체를 만들자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본생성자의 접근제어자를  private 으로 선언을 해야 함.
	// 2단계 : 정적 멤버로 선언을 해야 함 - static 으로 선언을 한다는 의미.
	private static AdminDAO instance = null;
	
	// 3단계 : 외부에서 객체 생성을 하지 못하게 접근을 제어 - private 기본 생성자를 만듬.
	private AdminDAO() { }
	
	// 4단계 : 기본 생성자 대신에 싱긑턴 객체를 return을 해 주는 getInstance()
	//        메서드를 만들어서 여기에 접근하게 하는 방법
	public static AdminDAO getInstance() {
		if(instance == null) {
			instance = new AdminDAO();
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
	
	public List<MemberDTO> MemberList() {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		MemberDTO dto = new MemberDTO();
		
		try {
			openConn();
			
			sql = "select * from member1 order by name desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setPoint(rs.getInt("point"));
				dto.setPermission(rs.getString("permission"));
				dto.setBirth(rs.getString("birth"));
				dto.setRegdate(rs.getString("regdate"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}
	
	// 회원 관리 폼에서 회원 리스트를 가져오는 메서드
	public List<MemberDTO> searchMember(String field, String name) {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		MemberDTO dto = new MemberDTO();
			try {
				openConn();
				
				if(field.equals("member_id")) {
					sql = "select * from member1 where id like ? order by regdate desc";
					
					pstmt = con.prepareStatement(sql);
				
					pstmt.setString(1, "%" + name +"%");
					
					rs = pstmt.executeQuery();
					
				}else if(field.equals("member_name")) {
					sql = "select * from member1 where name like ? order by regdate desc";
					
					pstmt = con.prepareStatement(sql);
				
					pstmt.setString(1, "%" + name +"%");
					
					rs = pstmt.executeQuery();
					
				}else if(field.equals("member_phone")) {
					sql = "select * from member1 where phone like ? order by regdate desc";
					
					pstmt = con.prepareStatement(sql);
				
					pstmt.setString(1, "%" + name +"%");
					
					rs = pstmt.executeQuery();
				}
				
				while(rs.next()) {
					dto.setId(rs.getString("id"));
					dto.setPwd(rs.getString("pwd"));
					dto.setName(rs.getString("name"));
					dto.setPhone(rs.getString("phone"));
					dto.setPoint(rs.getInt("point"));
					dto.setPermission(rs.getString("permission"));
					dto.setBirth(rs.getString("birth"));
					dto.setRegdate(rs.getString("regdate"));
					
					list.add(dto);
				}
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
			return list;
	}
	
	// 회원수를 가져오는 메서드
	public int getListCount() {
		int count = 0;
		
		try {
			openConn();
			
			sql = "select count(*) from member1";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	}
	
	// 회원의 권한을 바꾸는 메서드
	public int memApply(String id, String per) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "update member1 set permission = ? where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, per);
			pstmt.setString(2, id);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	//회원을 삭제하는 메서드
		public int memDelete(String id) {
			int result = 0;
			
			try {
				openConn();
				
				sql = "delete from member1 where id= ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
			return result;
		}
	
}
