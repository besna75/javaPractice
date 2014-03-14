/*	[GuestBook.java]	*/
/*
 *	시퀀스만들기
 *		create sequence guestbook_seq increment by 1 start with 1 nocycle;
 *	테이블만들기
 *		create table GUESTBOOK (
 *			GUESTBOOK_ID NUMBER NOT NULL,
 *			REGISTER DATE NOT NULL,
 *			NAME VARCHAR2(20) NOT NULL,
 *			EMAIL VARCHAR2(40) NOT NULL,
 *			PASSWORD VARCHAR2(10),
 *			CONTENT LONG NOT NULL,
 *			CONSTRAINT GUESTBOOK_PK PRIMARY KEY (GUESTBOOK_ID)
 *		);
 */
package madvirus.guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.io.StringReader;
import java.io.Reader;
import java.io.IOException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GuestBookManager {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private Statement stmt = null;
	private ResultSet rs = null;
		
	private static GuestBookManager instance = new GuestBookManager();
	public static GuestBookManager getInstance() {
		return instance;
	}
	private GuestBookManager() {}

	private void closeGuestBookManager(){
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	public void insert(GuestBook book) throws Exception {
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select guestbook_seq.nextval from dual");
			if (rs.next()) {
				book.setId(rs.getInt(1));
			}
			pstmt = conn.prepareStatement("insert into GUESTBOOK (GUESTBOOK_ID,REGISTER,NAME,EMAIL,PASSWORD,CONTENT) values (?,?,?,?,?,?)");
			pstmt.setInt(1, book.getId());
			pstmt.setTimestamp(2, book.getRegister());
			pstmt.setString(3, book.getName());
			pstmt.setString(4, book.getEmail());
			pstmt.setString(5, book.getPassword());
			pstmt.setCharacterStream(6, new StringReader(book.getContent()), book.getContent().length());
			pstmt.executeUpdate();
		} catch(SQLException ex) {
			throw new GuestBookException("insert", ex);
		} finally {
			closeGuestBookManager();
		}
	}


	public void update(GuestBook book) throws Exception {
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update GUESTBOOK set NAME=?,EMAIL=?,PASSWORD=?,CONTENT=? where GUESTBOOK_ID = ?");
			pstmt.setString(1, book.getName());
			pstmt.setString(2, book.getEmail());
			pstmt.setString(3, book.getPassword());
			pstmt.setCharacterStream(4, new StringReader(book.getContent()), book.getContent().length());
			pstmt.setInt(5, book.getId());
			pstmt.executeUpdate();
		} catch(SQLException ex) {
			throw new GuestBookException("update", ex);
		} finally {
			closeGuestBookManager();
		}
	}

	public void delete(int guestBookId) throws Exception {
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("delete from GUESTBOOK where GUESTBOOK_ID = ?");
			pstmt.setInt(1, guestBookId);
			pstmt.executeUpdate();
		} catch(SQLException ex) {
			throw new GuestBookException("delete", ex);
		} finally {
			closeGuestBookManager();
		}
	}

	public int getCount() throws Exception {
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select count(*) from GUESTBOOK");
			int count = 0;
			if (rs.next()) {
				count = rs.getInt(1);
			}
			return count;
		} catch(SQLException ex) {
			throw new GuestBookException("getCount", ex);
		} finally {
			closeGuestBookManager();
		}
	}

	public List getList(int startRow, int endRow) throws Exception {
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
				"select GUESTBOOK_ID,REGISTER,NAME,PASSWORD,EMAIL,CONTENT " +
				"from ( select GUESTBOOK_ID,REGISTER,NAME,PASSWORD,EMAIL,CONTENT,ROWNUM RNUM from GUESTBOOK order by GUESTBOOK_ID desc ) " +
				"where RNUM <= ? and RNUM >= ?");
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, startRow);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				List list = new java.util.ArrayList(endRow-startRow+1);
				do {
					GuestBook book = new GuestBook();
					book.setId(rs.getInt("GUESTBOOK_ID"));
					book.setRegister(rs.getTimestamp("REGISTER"));
					book.setName(rs.getString("NAME"));
					book.setEmail(rs.getString("EMAIL"));
					book.setPassword(rs.getString("PASSWORD"));
					Reader reader = null;
					try {
						reader = rs.getCharacterStream("CONTENT");
						char[] buff = new char[512];
						int len = -1;
						StringBuffer buffer = new StringBuffer(512);
						while( (len = reader.read(buff)) != -1) {
							buffer.append(buff, 0, len);
						}
						book.setContent(buffer.toString());
					} catch(IOException iex) {
						throw new GuestBookException("getList", iex);
					} finally {
						if (reader != null) try { reader.close(); } catch(IOException iex) {}
					}
					list.add(book);
				} while(rs.next());
				return list;
			} else {
				return java.util.Collections.EMPTY_LIST;
			}
		} catch(SQLException ex) {
			throw new GuestBookException("getList", ex);
		} finally {
			closeGuestBookManager();
		}
	}

	public GuestBook getGuestBook(int guestBookId) throws Exception {
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from GUESTBOOK where GUESTBOOK_ID = ? ");
			pstmt.setInt(1, guestBookId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				GuestBook book = new GuestBook();
				book.setId(rs.getInt("GUESTBOOK_ID"));
				book.setRegister(rs.getTimestamp("REGISTER"));
				book.setName(rs.getString("NAME"));
				book.setEmail(rs.getString("EMAIL"));
				book.setPassword(rs.getString("PASSWORD"));
				Reader reader = null;
				try {
					reader = rs.getCharacterStream("CONTENT");
					char[] buff = new char[512];
					int len = -1;
					StringBuffer buffer = new StringBuffer(512);
					while( (len = reader.read(buff)) != -1) {	buffer.append(buff, 0, len);	}
					book.setContent(buffer.toString());
				} catch(IOException iex) {
					throw new GuestBookException("getGuestBook", iex);
				} finally {
					if (reader != null)	try {reader.close();} catch(IOException iex) {}
				}
				return book;
			} else {
				return null;
			}
		} catch(SQLException ex) {
			throw new GuestBookException("getGuestBook", ex);
		} finally {
			closeGuestBookManager();
		}
	}
}
