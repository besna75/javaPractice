package test.action;

public class Main {
	public static void main(String [] args){
		try{
			Class name = Class.forName("test.action.SubTest1");
			Object obj = name.newInstance();
			// Object obj = new SubTest1();와 같은 객체 생성 방법이지만 forName()의 경로 변경으로 변경용이성을 가진다.
			Super s1 = (Super)obj ; //Super(조상클래스)로 형변환
			String view = s1.action();
			System.out.println(view);				
		}catch(Exception e){
		}
	}
}
