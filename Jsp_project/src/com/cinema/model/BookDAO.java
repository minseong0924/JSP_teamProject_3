package com.cinema.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BookDAO {
	Connection con = null;              // DB 연결하는 객체.
	PreparedStatement pstmt = null;     // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;                // SQL문을 실행 후 결과 값을 가지고 있는 객체.

	String sql = null;                  // 쿼리문을 저장할 객체.


	// 싱글톤 방식으로 BoardDAO 객체를 만들자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로 
	//       기본생성자의 접근제어자를  private 으로 선언을 해야 함.
	// 2단계 : 정적 멤버로 선언을 해야 함 - static 으로 선언을 한다는 의미.
	private static BookDAO instance = null;

	// 3단계 : 외부에서 객체 생성을 하지 못하게 접근을 제어 - private 기본 생성자를 만듬.
	private BookDAO() { }

	// 4단계 : 기본 생성자 대신에 싱긑턴 객체를 return을 해 주는 getInstance()
	//        메서드를 만들어서 여기에 접근하게 하는 방법
	public static BookDAO getInstance() {
		if(instance == null) {
			instance = new BookDAO();
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



	// 아이디가 id인 회원의 예매내역을 가져온다.
	public List<BookDTO> BookingSearch(String id) {
		List<BookDTO> list = new ArrayList<>();

		try {
			openConn();

			sql = "select * from "
					+ " (select row_number() "
					+ " over(order by bookingcode) rnum, "
					+ " b.*  from booking b where id like ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while(rs.next()) {
				BookDTO dto = new BookDTO();

				dto.setBookingcode(rs.getString("bookingcode"));
				dto.setId(rs.getString("id"));
				dto.setLocalcode(rs.getInt("localcode"));
				dto.setCinemaname(rs.getString("cinemaname"));
				dto.setTitle_ko(rs.getString("title_ko"));
				dto.setScreencode(rs.getInt("screencode"));
				dto.setCincode(rs.getInt("cincode"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
				dto.setStart_time(rs.getString("start_time"));
				dto.setEnd_time(rs.getString("end_time"));
				dto.setSeat_no(rs.getString("seat_no"));

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}	// bookingSearch() 메서드 end


	// 아이디가 id인 회원의 전체 예매 수를 확인하는 메서드
	public int getBookedCount(String id) {
		int count = 0;

		try {
			openConn();

			sql = "select count(*) from booking where id = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	}


	// 아이디가 id인 회원이 가장 좋아하는 극장 확인하기
	public String getLikeCinema(String id) {
		String result = "";

		try {
			openConn();

			sql = "select cinemaname from booking  where id = ? "
					+ " group by cinemaname having count(*) = "
					+ " (select max(mycount) from(select "
					+ " cinemaname,count(*) as mycount "
					+ " from booking group by cinemaname))";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				result = rs.getString(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}


	// 아이디가 id인 회원이 가장 좋아하는 극장 확인하기
	public String getLikeGenre(String id) {
		String result = "";

		try {
			openConn();

			sql = "select genre from (select b.id, b.title_ko, m.genre "
					+ " from booking b join movie m on b.title_ko = m.title_ko "
					+ " where id = ?) group by genre having count(*) = "
					+ " (select max(mycount) from(select genre,count(*) as mycount "
					+ " from (select b.id, b.title_ko, m.genre from booking b "
					+ " join movie m on b.title_ko = m.title_ko "
					+ " where id = ?) group by genre))";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				result = rs.getString(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	// 예매 좌석 조회
	public String bookingSeatOpen(int screencode) {
		String result = "";
		
		try {
			openConn();

			sql = "select * from booking where screencode = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, screencode);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				result += rs.getString("seat_no");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	//예매 추가
	public String bookingInsert(BookDTO dto) {
		int result = 0;
		String bookingcode = "";
		
		try {
			openConn();
			
			SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
			SimpleDateFormat format2 = new SimpleDateFormat ("HHmm");
					
			Date date = new Date();
					
			String day = format1.format(date);
			String time = format2.format(date);
			
			Random random = new Random();
			bookingcode = day + "-" + time + "-" + random.nextInt(10000);
			
			
			sql = "insert into booking "
					+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, bookingcode);
			pstmt.setString(2, dto.getId());
			pstmt.setInt(3, dto.getLocalcode());
			pstmt.setString(4, dto.getCinemaname());
			pstmt.setString(5, dto.getTitle_ko());
			pstmt.setInt(6, dto.getScreencode());
			pstmt.setInt(7, dto.getCincode());
			pstmt.setString(8, dto.getStart_date());
			pstmt.setString(9, dto.getEnd_date());
			pstmt.setString(10, dto.getStart_time());
			pstmt.setString(11, dto.getEnd_time());
			pstmt.setString(12, dto.getSeat_no());
			pstmt.setString(13, dto.getCredit());
			
			result = pstmt.executeUpdate();
			
			if(result>0) {
				return bookingcode;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return "";
	}
	
	public BookDTO bookingDetailOpen(String bookingcode) {
		BookDTO dto = new BookDTO();

		try {
			openConn();

			sql = "select * from booking where bookingcode= ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bookingcode);

			rs = pstmt.executeQuery();

			if(rs.next()) {

				dto.setBookingcode(rs.getString("bookingcode"));
				dto.setId(rs.getString("id"));
				dto.setLocalcode(rs.getInt("localcode"));
				dto.setCinemaname(rs.getString("cinemaname"));
				dto.setTitle_ko(rs.getString("title_ko"));
				dto.setScreencode(rs.getInt("screencode"));
				dto.setCincode(rs.getInt("cincode"));
				dto.setStart_date(rs.getString("start_date").substring(0, 10));
				dto.setEnd_date(rs.getString("end_date").substring(0, 10));
				dto.setStart_time(rs.getString("start_time"));
				dto.setEnd_time(rs.getString("end_time"));
				dto.setSeat_no(rs.getString("seat_no"));
				dto.setCredit(rs.getString("credit"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}
	
	/*public int bookingDelete(String code) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from booking where bookingcode = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, code);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}*/
	
	
	public int bookingDelete(String bookingcode) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from booking where bookingcode = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bookingcode);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public String getId(String bookingcode) {
		String result = "";
		
		try {
			openConn();
			
			sql = "select id from booking where bookingcode = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bookingcode);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				result = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	public int bookedDelete(String id) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from booking where id = ?";
			
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






