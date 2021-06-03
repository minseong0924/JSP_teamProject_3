package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.controller.Action;
import com.cinema.controller.ActionForward;
import com.cinema.model.MovieDAO;
import com.cinema.model.MovieDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MovieWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		MovieDTO dto = new MovieDTO();
		
		// 첨부파일이 저장될 경로(위치)
		String saveFolder =
				"C:\\Users\\kmsol\\git\\JSP_teamProject_3\\Jsp_project\\WebContent\\upload";
		
		// 첨부파일의 최대 크기
		int fileSize = 10 * 1024 * 1024;  // 10MB
		
		// 파일 업로드를 진행 시 이진 파일 업로드를 위한 객체 생성
		MultipartRequest multi = new MultipartRequest(
				request,                         // 일반적인 request 객체
				saveFolder,                      // 업로드 파일 저장 위치 
				fileSize,                        // 업로드할 파일의 최대 크기 
				"UTF-8",                         // 문자 인코딩 방식
				new DefaultFileRenamePolicy()    // 파일 이름이 중복이 안되게 설정
				);
		
		//int movie_code = Integer.parseInt(multi.getParameter("movie_code").trim());
		String movie_title_kor = multi.getParameter("movie_title_kor").trim();
		String movie_title_eng= multi.getParameter("movie_title_eng").trim();
		String movie_genre= multi.getParameter("movie_genre").trim();
		String movie_director= multi.getParameter("movie_director").trim();
		String movie_actor= multi.getParameter("movie_actor").trim();
		String movie_summary= multi.getParameter("movie_summary").trim();
		int movie_runningtime= Integer.parseInt(multi.getParameter("movie_runningtime").trim());
		String movie_age= multi.getParameter("movie_age").trim();
		String movie_nation= multi.getParameter("movie_nation").trim();
		String movie_opendate= multi.getParameter("movie_opendate").trim();
		String movie_state= multi.getParameter("movie_state").trim();
		String movie_type= multi.getParameter("movie_type").trim();
		
		// 자료실 폼에서 type="file" 로 되어 있으면
		// getFile() 메서드로 받아 주어야 함.
		File movie_poster= multi.getFile("movie_poster");
		
		if(movie_poster != null) {  // 첨부파일이 존재하는 경우
			
			// getName() : 첨부파일의 이름을 문자열로 반환해 주는 메서드
			String fileName = movie_poster.getName();
			
			// 날짜 객체 생성
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			// ........../upload/2021-05-21
			String homedir = saveFolder+"/"+year+"-"+month+"-"+day;
			
			
			// 날짜 폴더를 만들어 보자.
			File path1 = new File(homedir);
			if(!path1.exists()) {  // 폴더가 존재하지 않는 경우
				path1.mkdirs();    // 실제 폴더를 만드는 메서드.
			}
			
			// 파일 폴더를 만들어 보자. ==> 예) 홍길동_파일명
			// ........../upload/2021-05-21/홍길동_파일명
			String reFileName = movie_title_kor+"_"+fileName;
			
			movie_poster.renameTo(new File(homedir+"/"+reFileName));
			
			String fileDBName = 
					"/"+year+"-"+month+"-"+day+"/"+reFileName;
			
			dto.setPoster(fileDBName);
			
		}

		dto.setTitle_ko(movie_title_kor);
		dto.setTitle_en(movie_title_eng);
		dto.setAge(movie_age);
		dto.setActor(movie_actor);
		dto.setDirector(movie_director);
		dto.setGenre(movie_genre);
		dto.setMstate(movie_state);
		dto.setMtype(movie_type);
		dto.setNation(movie_nation);
		dto.setOpendate(movie_opendate);
		dto.setRunning_time(movie_runningtime);
		dto.setSummary(movie_summary);
		
		MovieDAO dao = MovieDAO.getInstance();
		
		int res = dao.movieWriteOk(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("movieList.do");
		}else {
			out.println("<script>");
			out.println("alert('등록 실패하였습니다.'");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
