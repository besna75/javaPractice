import java.util.*;

public class EqualsTest
{
	public static void main(String[] args) 
	{
		Employee alice1 = new Employee("Alice Adams", 75000, 1987, 12, 15);
		Employee alice2 = alice1;
		Employee alice3 = new Employee("Alice Adams", 75000, 1987, 12, 15);
		Employee bob = new Employee("Bob brandson", 50000, 1989, 10, 1);

		System.out.println("alice 1 == alice2 : " + (alice1 == alice2));

		System.out.println("alice 1 == alice3 : " + (alice1 == alice3));

		System.out.println("alice 1.equals(alice3) : " + alice1.equals(alice3));

		System.out.println("alice 1.equals(bob) : " + alice1.equals(bob));
		
		System.out.println("bob.toString() : " + bob);

		Manager carl = new Manager("Carl Cracker", 80000, 1987, 12, 15);
		Manager boss = new Manager("Carl Cracker", 80000, 1987, 12, 15);
		boss.setBonus(5000);
		System.out.println("boss.toString() : " + boss);
		System.out.println("carl.equals(boss) : " + carl.equals(boss));
		System.out.println("alice1.hashCode() : " + alice1.hashCode());
		System.out.println("alice3.hashCode() : " + alice3.hashCode());
		System.out.println("bob.hashCode() : " + bob.hashCode());
		System.out.println("carl.hashCode() : " + carl.hashCode());
	}
}

class Employee
{
	public Employee(String n, double s, int year, int month, int day)
	{
		name = n;
		salary = s;
		GregorianCalendar calendar = new GregorianCalendar(year, month - 1, day);
		hireDay = calendar.getTime();
	}

	public String getName()
	{
		return name;
	}

	public double getSalary()
	{
		return salary;
	}

	public Date getHireDay()
	{
		return hireDay;
	}

	public void raiseSalary(double byPercent)
	{
		double raise = salary *byPercent /100;
		salary += raise;
	}

	public boolean equals(Object otherObject)
	{
		// 객체가 같은 것인지 빠르게 검사
		if (this == otherObject) return true;

		// 명시된 매개변수가 null이면 반드시 false 반환
		if (otherObject == null) return false;

		// 쿨래스가 같지 않으면, 둘은 같을 수 없음.
		if (getClass() != otherObject.getClass())
			return false;

		// 이 시점에서 otherObject는 null이 아닌 Employee 객체
		Employee other = (Employee)otherObject;

		// 필드가 동일한 값을 가지고 있는지 검사
		return name.equals(other.name)
			&& salary == other.salary
			&& hireDay.equals(hireDay);
	}

	public int hashCode()
	{
		return 7* name.hashCode()
			+ 11 * new Double(salary).hashCode()
			+ 13 * hireDay.hashCode();
	}

	public String toString()
	{
		return getClass().getName()
			+ "[name = " + name
			+ "salary = " + salary
			+ "hireDay = " + hireDay
			+ "]";
	}

	private String name;
	private double salary;
	private Date hireDay;
}

class Manager extends Employee
{
	public Manager(String n, double s, int year, int month, int day)
	{
		super(n, s, year, month, day);
		bonus = 0;
	}

	public double getSalary()
	{
		double baseSalary = super.getSalary();
		return baseSalary + bonus;
	}

	public void setBonus(double b)
	{
		bonus = b;
	}

	public boolean eqauls(Object otherObject)
	{
		if(!super.equals(otherObject)) return false;
		Manager other = (Manager)otherObject;
		// super.equals 이 객체와 다른 객체가 같은 클래스인지
		// 검사

		return bonus == other.bonus;
	}
	public int hashCode()
	{
		return super.hashCode()
			+ 17 * new Double(bonus).hashCode();
	}

	public String toString()
	{
		return super.toString()
			+ "[bonus = " + bonus + "]";
	}
	private double bonus;
}