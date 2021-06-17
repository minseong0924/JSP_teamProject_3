package com.cinema.model;

public class ScreenDTO {
	private int screencode;
	private int moviecode;
	private int cinemacode;
	private int cincode;
	private int start_time;
	private int end_time;
	private String start_date;
	private String end_date;
	private String cinemaname;
	private String moviename;
	private String movienameEng;
	private String mtype;
	private String poster;
	private int localcode;
	private String localname;
	private String age;
	
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getMovienameEng() {
		return movienameEng;
	}
	public void setMovienameEng(String movienameEng) {
		this.movienameEng = movienameEng;
	}
	public String getLocalname() {
		return localname;
	}
	public void setLocalname(String localname) {
		this.localname = localname;
	}
	public int getLocalcode() {
		return localcode;
	}
	public void setLocalcode(int localcode) {
		this.localcode = localcode;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public String getMoviename() {
		return moviename;
	}
	public void setMoviename(String moviename) {
		this.moviename = moviename;
	}
	public int getScreencode() {
		return screencode;
	}
	public void setScreencode(int screencode) {
		this.screencode = screencode;
	}
	public int getMoviecode() {
		return moviecode;
	}
	public void setMoviecode(int moviecode) {
		this.moviecode = moviecode;
	}
	public int getCinemacode() {
		return cinemacode;
	}
	public void setCinemacode(int cinemacode) {
		this.cinemacode = cinemacode;
	}
	public int getCincode() {
		return cincode;
	}
	public void setCincode(int cincode) {
		this.cincode = cincode;
	}
	public int getStart_time() {
		return start_time;
	}
	public void setStart_time(int start_time) {
		this.start_time = start_time;
	}
	public int getEnd_time() {
		return end_time;
	}
	public void setEnd_time(int end_time) {
		this.end_time = end_time;
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
	public String getCinemaname() {
		return cinemaname;
	}
	public void setCinemaname(String cinemaname) {
		this.cinemaname = cinemaname;
	}
	
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	
	@Override
	public String toString() {
		return "ScreenDTO [screencode=" + screencode + ", moviecode=" + moviecode + ", cinemacode=" + cinemacode
				+ ", cincode=" + cincode + ", start_time=" + start_time + ", end_time=" + end_time + ", start_date="
				+ start_date + ", end_date=" + end_date + ", cinemaname=" + cinemaname + "]";
	}	

}
