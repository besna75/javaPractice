package db;
public class ZipDataBean {
	private String zipcode;
	private String area1;
	private String area2;
	private String area3;
	private String area4;
	public String getArea1() {
		return area1.trim();
	}
	public void setArea1(String area1) {
		this.area1 = area1.trim();
	}
	public String getArea2() {
		return area2.trim();
	}
	public void setArea2(String area2) {
		this.area2 = area2.trim();
	}
	public String getArea3() {
		return area3.trim();
	}
	public void setArea3(String area3) {
		this.area3 = area3.trim();
	}
	public String getArea4() {
		return area4.trim();
	}
	public void setArea4(String area4) {
		this.area4 = area4.trim();
	}
	public String getZipcode() {
		return zipcode.trim();
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode.trim();
	}
}
