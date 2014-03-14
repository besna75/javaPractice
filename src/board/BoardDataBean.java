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
	private int ref; // 글의 그룹
	private int re_step;  //글이 들어온 순서
	private int re_level; //글 우선순위

	/*﻿ 자바빈의 메소드 선언
	 * 프로퍼티에 접근하기위한 getXxx(), setXxx()메소드는 접근제어자를 public로 선언해서 작성 */  

	    public void setNum(int num){ 
	     this.num=num;
	    }
	    public void setWriter (String writer) { // 작성자
	        this.writer = writer;
	    }
	    public void setSubject (String subject) { // 글제목
	        this.subject = subject;
	    }
	    public void setEmail (String email) { //이메일
	        this.email = email;
	    }
	    public void setContent (String content) { //내용
	        this.content = content;
	    }
	    public void setPasswd (String passwd) { //비밀번호
	        this.passwd = passwd;
	    }
	    public void setReg_date (Timestamp reg_date) { //작성일
	        this.reg_date = reg_date;
	    }
	    public void setReadcount(int readcount){ //조회수
	    this.readcount=readcount;
	    }
	    public void setIp (String ip) { //IP
	        this.ip = ip;
	    }
	    public void setRef (int ref) { //글의 그룹
	        this.ref = ref;
	    }

	     public void setRe_step (int re_step) { //글이 들어온 순서
	        this.re_step=re_step;
	    }
	     public void setRe_level (int re_level) { //글의 우선순위
	        this.re_level=re_level;
	    }

	    public int getNum(){
	     return num;
	    }
	    public int getReadcount(){
	        return readcount;
	    }
	    public String getWriter () {
	        return writer;
	    }
	    public String getSubject () {
	        return subject;
	    }
	    public String getEmail () {
	        return email;
	    }
	    public String getContent () {
	        return content;
	    }
	    public String getPasswd () {
	        return passwd;
	    }
	    public Timestamp getReg_date () {
	        return reg_date;
	    }
	    public String getIp () {
	        return ip;
	    }
	    public int getRef () {
	        return ref;
	    }

	    public int getRe_step () {
	        return re_step;
	    }
	    public int getRe_level () {
	        return re_level;
	    }  
	    
	}
