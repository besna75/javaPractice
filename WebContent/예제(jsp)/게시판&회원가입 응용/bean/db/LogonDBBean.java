package db;
import java.io.IOException;
import java.io.Reader;
import java.sql.*;

import javax.sql.*;
import javax.naming.*;
 
import java.sql.*;
import java.util.List;

import javax.sql.*;
import javax.naming.*;


public class LogonDBBean{
//	Ŀ�ؼ� Ǯ
	private LogonDBBean(){}
	private static LogonDBBean instance = new LogonDBBean();
	public static LogonDBBean getInstance(){
		return instance;
	}
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/orcl");
		return ds.getConnection();
	}
/*
 * insertMember(){}
 * *	ȸ�����԰��� : ȸ������ �Է�
 * *		addForm.jsp
 * *		addProc.jsp
 * updateMember(){}
 * *	ȸ���������� : ȸ������ ����
 * *		modForm.jsp
 * *		modProc.jsp
 * deleteMember(){}
 * *	ȸ��Ż����� : ȸ������ ����
 * *		delForm.jsp
 * *		delProc.jsp
 * 
 * getMember(){}
 * *	ȸ���������� : ȸ������ ����
 * *		modForm.jsp
 * *	ȸ���������� : ȸ������ ����
 * *		viewMem.jsp
 * listMember(){}
 * *	ȸ���������� : ȸ������ ����Ʈ
 * *		listMem.jsp
 * countMember(){}
 * *	ȸ���������� : ȸ�� ��
 * *		listMem.jsp
 * 
 * checkID(){}
 * *	ȸ�����԰��� : ȸ�����̵��ߺ� üũ
 * *		confirmId.jsp
 * checkUser(){}
 * *	ȸ���α���   : ���̵�, �н����� üũ
 * *		logForm.jsp
 * 
 * ��Ÿ
 * checkSess(){}
 * *	����üũ	: checkUser(){} ��ü 
 */
	public void insertMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

        try {
        	conn = getConnection();
        	
            pstmt = conn.prepareStatement("insert into MEMBER values (?,?,?,?,?,?,?,?,?,?)");
            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPasswd());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getJumin1());
            pstmt.setString(5, member.getJumin2());
            pstmt.setString(6, member.getEmail());
            pstmt.setString(7, member.getBlog());
			pstmt.setTimestamp(8, member.getReg_date());
            pstmt.setString(9, member.getZipcode());
            pstmt.setString(10, member.getAddress());
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
	
 
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String dbpasswd="";
		int x=-1;

		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select passwd from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();
			
			if(rs.next()){
				dbpasswd= rs.getString("passwd");
				if(dbpasswd.equals(passwd))
					x= 1;	//���� ����
				else
					x= 0;	//��й�ȣ Ʋ��
			}else
				x= -1;		//�ش� ���̵� ����
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return x;
	}
	

	public int confirmId(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String dbpasswd="";
		int x=-1;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select id from MEMBER where id = ?");
			pstmt.setString(1, id);
			
			rs= pstmt.executeQuery();
			
			if(rs.next())
				x= 1;	//�ش� ���̵� ����
			else
				x= -1;	//�ش� ���̵� ����
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}


	public LogonDataBean getMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogonDataBean member=null;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new LogonDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setJumin1(rs.getString("jumin1"));
				member.setJumin2(rs.getString("jumin2"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress(rs.getString("address"));
			}
		} catch(Exception ex) {
		ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return member;
	}
	

	public void updateMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update MEMBER set passwd=?,name=?,email=?,blog=?,zipcode=?,address=? "+"where id=?");
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getBlog());
			pstmt.setString(5, member.getId());
			pstmt.setString(6, member.getZipcode());
			pstmt.setString(7, member.getAddress());
			
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	}
	

	public int deleteMember(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String dbpasswd="";
		int x=-1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dbpasswd= rs.getString("passwd");
				if(dbpasswd.equals(passwd)){
					pstmt = conn.prepareStatement("delete from MEMBER where id=?");
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x= 1; //ȸ��Ż�� ����
				}else
					x= 0; //��й�ȣ Ʋ��
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}

	public int countDB(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		int count = 0;
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from member ");
			rs = pstmt.executeQuery();
			if(rs.next())	count = rs.getInt(1);
		}catch(Exception e){
			
		}finally{
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return count;
	}
	public List getList(int startRow, int endRow) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		List list = new java.util.ArrayList(endRow-startRow+1);
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
				"select id,passwd,name,jumin1,jumin2,email,blog,reg_date,zipcode,address " +
				"from ( select id,passwd,name,jumin1,jumin2,email,blog,reg_date,zipcode,address, ROWNUM RNUM from member order by GUESTBOOK_ID desc ) " +
				"where RNUM <= ? and RNUM >= ?");
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, startRow);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					LogonDataBean member = new LogonDataBean();
					member.setId(rs.getString("id"));
					member.setPasswd(rs.getString("password"));
					member.setName(rs.getString("name"));
		            member.setJumin1(rs.getString("jumin1"));
		            member.setJumin2(rs.getString("jumin2"));
		            member.setEmail(rs.getString("email"));
		            member.setBlog(rs.getString("blog"));
		            member.setReg_date(rs.getTimestamp("reg_date"));
					member.setZipcode(rs.getString("zipcode"));
					member.setAddress(rs.getString("address"));
					list.add(member);
				} while(rs.next());
			} else {
				list = java.util.Collections.EMPTY_LIST;
			}
		} catch(SQLException ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return list;
	}
}
