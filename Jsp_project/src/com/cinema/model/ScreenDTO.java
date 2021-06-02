package com.cinema.model;

public class ScreenDTO {
	private int screencode;
	private int moviecode;
	private int cinemacode;
	private int cincode;
	private int start_time;
	private int end_time;
	
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
}
