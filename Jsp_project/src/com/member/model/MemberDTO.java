package com.member.model;

public class MemberDTO {
	private String id;			// ȸ�� ���̵�
	private String pwd;			// ȸ�� ��й�ȣ
	private String name; 		// ȸ�� �̸�
	private String phone; 		// ȸ�� ��ȭ��ȣ
	private int point;			// ȸ�� ����Ʈ
	private String permission; // ȸ�� ����
	private String birth;		// ȸ�� ����
	private String regdate;		// ȸ�� ������
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getPermission() {
		return permission;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
}
