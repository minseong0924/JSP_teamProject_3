package com.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	Connection con = null;              // DB �����ϴ� ��ü.
	PreparedStatement pstmt = null;     // DB�� SQL���� �����ϴ� ��ü.
	ResultSet rs = null;                // SQL���� ���� �� ��� ���� ������ �ִ� ��ü.
	
	String sql = null;                  // �������� ������ ��ü.

	// �̱��� ������� MemberDAO ��ü�� ������.
	// 1�ܰ� : �̱��� ������� ��ü�� ����� ���ؼ��� �켱������ 
	//       �⺻�������� ���������ڸ�  private ���� ������ �ؾ� ��.
	// 2�ܰ� : ���� ����� ������ �ؾ� �� - static ���� ������ �Ѵٴ� �ǹ�.
	private static MemberDAO instance = null;
	
	// 3�ܰ� : �ܺο��� ��ü ������ ���� ���ϰ� ������ ���� - private �⺻ �����ڸ� ����.
	private MemberDAO() { }
	
	// 4�ܰ� : �⺻ ������ ��ſ� �̃P�� ��ü�� return�� �� �ִ� getInstance()
	//        �޼��带 ���� ���⿡ �����ϰ� �ϴ� ���
	public static MemberDAO getInstance() {
		if(instance == null) {
			instance = new MemberDAO();
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
}
