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

import com.member.model.MemberDTO;

public class AdminDAO {
	Connection con = null;              // DB �����ϴ� ��ü.
	PreparedStatement pstmt = null;     // DB�� SQL���� �����ϴ� ��ü.
	ResultSet rs = null;                // SQL���� ���� �� ��� ���� ������ �ִ� ��ü.
	
	String sql = null;                  // �������� ������ ��ü.

	// �̱��� ������� AdminDAO ��ü�� ������.
	// 1�ܰ� : �̱��� ������� ��ü�� ����� ���ؼ��� �켱������ 
	//       �⺻�������� ���������ڸ�  private ���� ������ �ؾ� ��.
	// 2�ܰ� : ���� ����� ������ �ؾ� �� - static ���� ������ �Ѵٴ� �ǹ�.
	private static AdminDAO instance = null;
	
	// 3�ܰ� : �ܺο��� ��ü ������ ���� ���ϰ� ������ ���� - private �⺻ �����ڸ� ����.
	private AdminDAO() { }
	
	// 4�ܰ� : �⺻ ������ ��ſ� �̃P�� ��ü�� return�� �� �ִ� getInstance()
	//        �޼��带 ���� ���⿡ �����ϰ� �ϴ� ���
	public static AdminDAO getInstance() {
		if(instance == null) {
			instance = new AdminDAO();
		}
		return instance;
	}  // getInstance() �޼��� end
	
	// DB �����ϴ� �۾��� �����ϴ� �޼��� - DBCP������� ���� ����
	public void openConn() {
		
		try {
			// 1�ܰ� : JNDI ���� ��ü ����.
			Context ctx = new InitialContext();
			
			// 2�ܰ� : lookup() �޼��带 �̿��Ͽ� ��Ī�Ǵ� Ŀ�ؼ��� ã�´�.
			DataSource ds = 
				(DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
			
			// 3�ܰ� : DataSource ��ü�� �̿��Ͽ� Ŀ�ؼ� ��ü�� �ϳ� �����´�.
			con = ds.getConnection();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}  // openConn() �޼��� end
	
	// DB�� ����� ��ü�� �����ϴ� �޼���
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
				
		}  // closeConn() �޼��� end
		
	// ����� ����/���� ������ ȸ�� ����Ʈ�� ��ȸ�ϴ� �޼���
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
				}else if(field.equals("member_name")) {
					sql = "select * from member1 where name like ? order by regdate desc";
					
					pstmt = con.prepareStatement(sql);
				
					pstmt.setString(1, "%" + name +"%");
					
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
				}else if(field.equals("member_phone")) {
					sql = "select * from member1 where phone like ? order by regdate desc";
					
					pstmt = con.prepareStatement(sql);
				
					pstmt.setString(1, "%" + name +"%");
					
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
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
			return list;
	}
	
	// ��ü ȸ������ Ȯ���ϴ� �޼���
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
}
