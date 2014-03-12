package ch11.logon;
import java.sql.Timestamp;

public class LogonDataBean{

	private String id; //아이디
	private String passwd; //비밀번호
	private String name; //이름
	private String jumin1; //주민번호 앞
	private String jumin2; //주민번호 뒤
	private String email; //이메일
	private String blog; //블로그
	private Timestamp reg_date; //작성일	
	private String grade; //회원등급

	public void setId (String id){
		this.id = id;
	}
    public void setPasswd (String passwd){
		this.passwd = passwd;
	}
	public void setName (String name){
		this.name = name;
	}
	public void setJumin1 (String jumin1){
		this.jumin1 = jumin1;
	}
	public void setJumin2 (String jumin2){
		this.jumin2 = jumin2;
	}
	public void setEmail (String email){
		this.email = email;
	}
	public void setBlog (String blog){
		this.blog = blog;
	}
	public void setReg_date (Timestamp reg_date){
		this.reg_date = reg_date;
	}

	public String getId(){
 		return id; 
 	}
	public String getPasswd(){
 		return passwd; 
 	}
	public String getName(){
 		return name; 
 	}
	public String getJumin1(){
 		return jumin1; 
 	}
	public String getJumin2(){
 		return jumin2; 
 	}
	public String getEmail(){
 		return email; 
 	}
	public String getBlog(){
 		return blog; 
 	}

	public Timestamp getReg_date(){
 		return reg_date; 
 	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}	
}