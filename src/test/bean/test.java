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


package test.bean; //  package ��Ű����; (������ ��������)
import ***.***.*** //��Ű���� ���� Ŭ���� Ǯ����(������ ��������)


public class Tv { // class Ŭ������{ }
/* �ڹٺ��� ������Ƽ(�������) ���� */
 private String color; 
        // ������Ƽ�� ���� �����ϱ� ���� �ʵ�� �������� private�� ������
/*�ڹٺ��� �޼ҵ� ����*/
 public void setColor(String color){ 
        /* ������Ƽ�� �����ϱ����� getXxx(), setXxx()�޼ҵ�� ���������ڸ� public�� �����ؼ� �ۼ� 
         	setXxx() ==> ����������� ������ �ϴ� ������Ƽ�� �� ����
         	getXxx() ==> ����������� ������ �ϴ� ������Ƽ�� ���尪�� ���
                      �ϳ��� ������Ƽ �� �ϳ��� setXxx(), getXxx() �޼ҵ尡 ������*/
  this.color = color;
 }
 public String getColor(){
  return color;
 }
}
