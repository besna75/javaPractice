package test.bean;

public class Bean {
	private String id;
	private String pw;
	private String age;
	private String name;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
/*	public void setId(String id){ //int로 age를 받았다고 하여도 String로 맞추어 준다음 수행부에서 parseInt로 바꾸어준다.
		this.id = id;
	}
*/
}
