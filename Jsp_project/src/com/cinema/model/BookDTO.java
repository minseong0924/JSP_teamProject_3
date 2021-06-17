package com.cinema.model;

public class BookDTO {
	private String bookingcode;
	private String id;
	private int localcode;
	private String cinemaname;
	private String title_ko;
	private int screencode;
	private int cincode;
	private String start_date;
	private String end_date;
	private String start_time;
	private String end_time;
	private String seat_no;
	private String credit;
	
	public String getCredit() {
		return credit;
	}
	public void setCredit(String credit) {
		this.credit = credit;
	}
	public String getBookingcode() {
		return bookingcode;
	}
	public void setBookingcode(String bookingcode) {
		this.bookingcode = bookingcode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getLocalcode() {
		return localcode;
	}
	public void setLocalcode(int localcode) {
		this.localcode = localcode;
	}
	public String getCinemaname() {
		return cinemaname;
	}
	public void setCinemaname(String cinemaname) {
		this.cinemaname = cinemaname;
	}
	public String getTitle_ko() {
		return title_ko;
	}
	public void setTitle_ko(String title_ko) {
		this.title_ko = title_ko;
	}
	public int getScreencode() {
		return screencode;
	}
	public void setScreencode(int screencode) {
		this.screencode = screencode;
	}
	public int getCincode() {
		return cincode;
	}
	public void setCincode(int cincode) {
		this.cincode = cincode;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getSeat_no() {
		return seat_no;
	}
	public void setSeat_no(String seat_no) {
		this.seat_no = seat_no;
	}

}