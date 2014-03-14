package test.bean;

class test {
	public static void main(String[] args) throws Exception{
		Class name = Class.forName("java.util.Date");
		Object obj = name.newInstance(); // Object obj = new Date()
		System.out.println(obj);
		
		//Date day = new Date();
		//System.out.println(day);
	}
}


package test.bean; //  package 패키지명; (없으면 생략가능)
import ***.***.*** //패키지명 포함 클래스 풀네임(없으면 생략가능)


public class Tv { // class 클래스명{ }
/* 자바빈의 프로퍼티(멤버변수) 선언 */
 private String color; 
        // 프로퍼티란 값을 저장하기 위한 필드로 접근제어 private로 선언함
/*자바빈의 메소드 선언*/
 public void setColor(String color){ 
        /* 프로퍼티에 접근하기위한 getXxx(), setXxx()메소드는 접근제어자를 public로 선언해서 작성 
         	setXxx() ==> 데이터저장소 역할을 하는 프로퍼티에 값 저장
         	getXxx() ==> 데이터저장소 역할을 하는 프로퍼티의 저장값을 사용
                      하나의 프로퍼티 당 하나의 setXxx(), getXxx() 메소드가 존재함*/
  this.color = color;
 }
 public String getColor(){
  return color;
 }
}
