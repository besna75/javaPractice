package test.action;

public class Main {
	public static void main(String [] args){
		try{
			Class name = Class.forName("test.action.SubTest1");
			Object obj = name.newInstance();
			// Object obj = new SubTest1();�� ���� ��ü ���� ��������� forName()�� ��� �������� ������̼��� ������.
			Super s1 = (Super)obj ; //Super(����Ŭ����)�� ����ȯ
			String view = s1.action();
			System.out.println(view);				
		}catch(Exception e){
		}
	}
}
