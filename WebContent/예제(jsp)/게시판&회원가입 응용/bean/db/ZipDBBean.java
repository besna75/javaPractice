package db;
import java.io.IOException;
import java.io.Reader;
import java.sql.*;

import javax.sql.*;
import javax.naming.*;
 
import java.util.Vector;


public class ZipDBBean {
//	Ä¿³Ø¼Ç Ç®
	private ZipDBBean(){}
	private static ZipDBBean instance = new ZipDBBean();
	public static ZipDBBean getInstance(){
		return instance;
	}
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	public Vector zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();
		try {
			con = getConnection();
			String strQuery = "select * from zipcode where area3 like '"+area3+"%'";
			pstmt = con.prepareStatement(strQuery);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ZipDataBean tempZipcode = new ZipDataBean();
				tempZipcode.setZipcode(rs.getString("zipcode"));
				tempZipcode.setArea1(rs.getString("area1"));
				tempZipcode.setArea2(rs.getString("area2"));
				tempZipcode.setArea3(rs.getString("area3"));
				tempZipcode.setArea4(rs.getString("area4"));
				vecList.addElement(tempZipcode);
			}
		}catch(Exception ex) {
			System.out.println("Exception" + ex);
		}finally{
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (con != null) try { con.close(); } catch(SQLException ex) {}
		}
		return vecList;
	}
}
