package board;
import java.sql.Timestamp;

public class BoardDataBean{
	/*﻿ 자바빈의 프로퍼티(멤버변수) 선언
	 * 프로퍼티란 값을 저장하기 위한 필드로 접근제어 private로 선언함  */ 
	
	private int num;  //글번호 
	private String writer; //작성자
	private String subject; //글제목
	private String email; //이메일
	private String content; //내용
	private String passwd; //비밀번호
	private Timestamp reg_date;  // 작성일
	private int readcount; //조회수
	private String ip; //ip
	private int ref; // 글의 그룹 (글+답글)
	private int re_step;  //글의 순위 (같은 page 글들의 구분을 위한 것, 예. A글의 답글인 A-1과 A-2의 공백 크기는 같다. A의 답답글인 A-1-1은 공백의 크기가 2배가 된다)
	private int page_step; //글 우선순위 (0-새글 , 1-답글 , 2-답글의 답글)

	/*﻿ 자바빈의 메소드 선언
	 * 프로퍼티에 접근하기위한 getXxx(), setXxx()메소드는 접근제어자를 public로 선언해서 작성 */  
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getPage_step() {
		return page_step;
	}
	public void setPage_step(int page) {
		this.page_step = page_step;
	}	  
	    
	}
