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
					"or ? between start_time and end_time) "+
					"and (start_date between ? and ? "+
					"or end_date between ? and ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCinemacode());
			pstmt.setInt(2, dto.getCincode());
			pstmt.setInt(3, dto.getStart_time());
			pstmt.setInt(4, dto.getEnd_time());
			pstmt.setString(5, dto.getStart_date());
			pstmt.setString(6, dto.getEnd_date());
			pstmt.setString(7, dto.getStart_date());
			pstmt.setString(8, dto.getEnd_date());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = -2;
			} else {
			
				sql = "insert into screen "
						+ " values(?,?,?,?,?,?,?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, count);
				pstmt.setInt(2, dto.getMoviecode());
				pstmt.setInt(3, dto.getCinemacode());
				pstmt.setString(4, dto.getCinemaname());
				pstmt.setInt(5, dto.getCincode());
				pstmt.setInt(6, dto.getStart_time());
				pstmt.setInt(7, dto.getEnd_time());
				pstmt.setString(8, dto.getStart_date());
				pstmt.setString(9, dto.getEnd_date());
				
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
			
			sql = "select * from screen";
			
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
				dto.setStart_date(rs.getString("start_date").substring(0, 10));
				dto.setEnd_date(rs.getString("end_date").substring(0, 10));
				dto.setCinemaname(rs.getString("cinemaname"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	}
	
	public List<ScreenDTO> screenOpen(int page, int rowsize) {
		List<ScreenDTO> list = new ArrayList<>();
		
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		try {
			openConn();
			
			sql = "select * from(SELECT b.*, ROW_NUMBER() OVER(ORDER BY screencode DESC) rn FROM screen b) where rn >= ? and rn <= ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreenDTO dto = new ScreenDTO();
				dto.setScreencode(rs.getInt("screencode"));
				dto.setMoviecode(rs.getInt("moviecode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCincode(rs.getInt("cincode"));
				dto.setStart_time(rs.getInt("start_time"));
				dto.setEnd_time(rs.getInt("end_time"));
				dto.setStart_date(rs.getString("start_date").substring(0, 10));
				dto.setEnd_date(rs.getString("end_date").substring(0, 10));
				dto.setCinemaname(rs.getString("cinemaname"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	}
	
	public List<ScreenDTO> bookingScreenOpen(String flag, String str) {
		List<ScreenDTO> list = new ArrayList<>();
//		String screenlist = "";
		
		try {
			openConn();
			
			sql = "select * from screen where ? between start_date and end_date";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, str);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreenDTO dto = new ScreenDTO();
				dto.setScreencode(rs.getInt("screencode"));
				dto.setMoviecode(rs.getInt("moviecode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCincode(rs.getInt("cincode"));
				dto.setStart_time(rs.getInt("start_time"));
				dto.setEnd_time(rs.getInt("end_time"));
				dto.setStart_date(rs.getString("start_date").substring(0, 10));
				dto.setEnd_date(rs.getString("end_date").substring(0, 10));
				dto.setCinemaname(rs.getString("cinemaname"));
				
//				screenlist += dto.toString();
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
				dto.setCinemaname(rs.getString("cinemaname"));
				dto.setCincode(rs.getInt("cincode"));
				dto.setStart_time(rs.getInt("start_time"));
				dto.setEnd_time(rs.getInt("end_time"));
				dto.setStart_date(rs.getString("start_date").substring(0, 10));
				dto.setEnd_date(rs.getString("end_date").substring(0, 10));
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
					"or ? between start_time and end_time)"+
					"and (start_date between ? and ? "+
					"or end_date between ? and ?)";;
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getScreencode());
			pstmt.setInt(2, dto.getCinemacode());
			pstmt.setInt(3, dto.getCincode());
			pstmt.setInt(4, dto.getStart_time());
			pstmt.setInt(5, dto.getEnd_time());
			pstmt.setString(6, dto.getStart_date());
			pstmt.setString(7, dto.getEnd_date());
			pstmt.setString(8, dto.getStart_date());
			pstmt.setString(9, dto.getEnd_date());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = -2;
			} else {
			
				sql = "update screen set " + 
						"start_time = ?, " + 
						"end_time = ?, " + 
						"start_date = ?, " + 
						"end_date = ? " + 
						"where screencode = ? ";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, dto.getStart_time());
				pstmt.setInt(2, dto.getEnd_time());
				pstmt.setString(3, dto.getStart_date());
				pstmt.setString(4, dto.getEnd_date());
				pstmt.setInt(5, dto.getScreencode());
				
				result = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
		
	}
	
	public int getListCount() {
		int count = 0;
		
		try {
			
			openConn();
			
			sql = "select count(*) from screen";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
			
			rs.close(); pstmt.close(); con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return count;
	}
	
	public List<ScreenDTO> searchScreenList(String field, String name, int page, int rowsize) {
		List<ScreenDTO> list = new ArrayList<ScreenDTO>();
		
		//해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		//해당 페이지에서 마지막 번호
		int endNo = (page * rowsize);
		
		openConn();
		
		try {
			if( field.equals("screencode")) {
				// 상영코드로 검색한 경우
				sql = "select * from "
						+ " (select row_number() "
						+ " over(order by screencode desc) rnum,"
						+ " b.* from screen b "
						+ " where screencode like ?) "
						+ " where rnum >= ? and rnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+name+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
			
			} else if(field.equals("moviecode")) {
				// 영화명+코드로 검색한 경우
				sql = "select * from "+
					  "(select row_number() over(order by screencode desc) rnum, b.* "+
				      "from screen b inner join movie m "+
					  "on b.moviecode = m.moviecode "+
					  "where b.moviecode like ? "+
					  "or m.title_ko like ?) "+
					  "where rnum >= ? and rnum <= ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+name+"%");
				pstmt.setString(2, "%"+name+"%");
				pstmt.setInt(3, startNo);
				pstmt.setInt(4, endNo);
			
			} else if(field.equals("cinemacode")){
				// 상영지점+코드로 검색한 경우
				sql = "select * from "+
					  "(select row_number() over(order by screencode desc) rnum, b.* "+
					  "from screen b inner join cinema c "+
					  "on b.cinemacode = c.cinemacode "+
					  "where b.cinemacode like ? "+
					  "or c.cinemaname like ?) "+
					  "where rnum >= ? and rnum <= ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+name+"%");
				pstmt.setString(2, "%"+name+"%");
				pstmt.setInt(3, startNo);
				pstmt.setInt(4, endNo);
				
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreenDTO dto = new ScreenDTO();
				dto.setScreencode(rs.getInt("screencode"));
				dto.setMoviecode(rs.getInt("moviecode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCinemaname(rs.getString("cinemaname"));
				dto.setCincode(rs.getInt("cincode"));
				dto.setStart_time(rs.getInt("start_time"));
				dto.setEnd_time(rs.getInt("end_time"));
				dto.setStart_date(rs.getString("start_date").substring(0, 10));
				dto.setEnd_date(rs.getString("end_date").substring(0, 10));
				
				list.add(dto);
			}
			
			// open 객체 닫기
			rs.close(); pstmt.close(); con.close();
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int searchListCount(String field, String name) {
		int count = 0;
		
		openConn();
		
		try {
			if(field.equals("screencode")) { //상영코드 검색
				sql = "select count(*) from screen "
						+ " where screencode like ? "
						+ " order by screencode desc";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+name+"%");
			} else if(field.equals("moviecode")) { //영화코드+영화명 검색
				sql = "select count(*) "
						+ "from screen s inner join movie m "
						+ "on s.moviecode = m.moviecode "
						+ "where s.moviecode like ? "
						+ "or m.title_ko like ? "
						+ "order by screencode desc";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+name+"%");
				pstmt.setString(2, "%"+name+"%");
				
			} else if(field.equals("cinemacode")) { //지점코드+지점명 검색
				sql = "select count(*) "
						+ "from screen s inner join cinema c "
						+ "on s.cinemacode = c.cinemacode "
						+ "where s.cinemacode like ? "
						+ "or c.cinemaname like ? "
						+ "order by screencode desc";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+name+"%");
				pstmt.setString(2, "%"+name+"%");
			}

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			// open 객체 닫기
			rs.close(); pstmt.close(); con.close();
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	public String ScreenList(String loc, String title, String today) {
		String result = "";
		int localcode = 0;
		int moviecode = 0;
		String cinemaname = "";
		try {
			openConn();
			
			sql = "select localcode from local where localname = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loc);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				localcode = rs.getInt(1);
			}
			
			sql= "select moviecode from movie where title_ko = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				moviecode = rs.getInt(1);
			}
			
			sql = "select s.*,m.mtype\n" + 
					"from screen s, movie m\n" + 
					"where s.moviecode = m.moviecode\n" + 
					"and s.cinemacode in(select cinemacode from cinema where localcode = ?)\n" + 
					"and s.moviecode = ?\n" + 
					"and start_date = TO_DATE(?, 'YYYY-MM-DD') order by s.cinemacode, s.cincode";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, localcode);
			pstmt.setInt(2, moviecode);
			pstmt.setString(3, today);
			
			rs = pstmt.executeQuery();
			
				result += "<screen1>";
			
			while(rs.next()) {
				result += "<screen>";
				result += "<screencode>" + rs.getInt("screencode") + "</screencode>";
				result += "<moviecode>" + rs.getInt("moviecode") + "</moviecode>";
				result += "<cinemacode>" + rs.getInt("cinemacode") + "</cinemacode>";
				result += "<cinemaname>" + rs.getString("cinemaname") + "</cinemaname>";
				result += "<cincode>" + rs.getInt("cincode") + "</cincode>";
				result += "<start_time>" + rs.getInt("start_time") + "</start_time>";
				result += "<end_time>" + rs.getInt("end_time") + "</end_time>";
				result += "<mtype>" + rs.getString("mtype") + "</mtype>";
				result += "</screen>";
			}
				result += "</screen1>";
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	public List<ScreenDTO> ScreenList(String cinemaname, String date) {
		List<ScreenDTO> list = new ArrayList<>();
		
		try {
			openConn();
			
			sql = "select s.*, m.title_ko, m.mtype\n" + 
					"from screen s, movie m \n" + 
					"where s.cinemaname=? \n" + 
					"and s.moviecode = m.moviecode\n" + 
					"and start_date = TO_DATE(?, 'YYYY-MM-DD') \n" + 
					"order by title_ko, cincode, start_time";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cinemaname);
			pstmt.setString(2, date);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ScreenDTO dto = new ScreenDTO();
				
				dto.setScreencode(rs.getInt("screencode"));
				dto.setMoviecode(rs.getInt("moviecode"));
				dto.setCinemacode(rs.getInt("cinemacode"));
				dto.setCinemaname(rs.getString("cinemaname"));
				dto.setCincode(rs.getInt("cincode"));
				dto.setStart_time(rs.getInt("start_time"));
				dto.setEnd_time(rs.getInt("end_time"));
				dto.setStart_date(rs.getString("start_date").substring(0, 10));
				dto.setEnd_date(rs.getString("end_date").substring(0, 10));
				dto.setMoviename(rs.getString("title_ko"));
				dto.setMtype(rs.getString("mtype"));
				
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
}
