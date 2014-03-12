package board;
import java.sql.*;

import javax.sql.*;
import javax.naming.*;

import java.util.*; 

public class BoardDBBean {

	private static BoardDBBean instance = new BoardDBBean();
	
	public static BoardDBBean getInstance() {
		return instance;
	
	}
	private BoardDBBean() {}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	public void insertArticle(BoardDataBean article) throws Exception {
		// -> writePro.jsp
		
		Connection conn = null;
		PreparedStatement pstmt = null; // Query�� ���� pstmt ���� �� �ʱ�ȭ
		ResultSet rs = null; // ResultSet (�����ͺ��̽��� ������ ���� ����� ��������)
		
		int num = article.getNum(); // ���� ������ȣ
		int ref = article.getRef(); // ���� �׷�
		int re_step = article.getRe_step(); // ��� �޸� ����
		int re_level = article.getRe_level(); //�� �켱���� 0-���� , 1-��� , 2-����� ���
		int number = 0; 
		
		String sql="";
		
		try {
			conn = getConnection(); 
			pstmt = conn.prepareStatement("select max(num) from board"); // board���̺��� �ִ밪 
			rs = pstmt.executeQuery();//���� ����
			
			if (rs.next())
				number=rs.getInt(1)+1;	// 0+1=1:���   ,   1+1=2:����� ���
			else
				number=1; // ���
			
			if (num!=0) // ������ �ƴҶ�
			{ 
				sql="update board set re_step = re_step+1 where ref = ? and re_step > ?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, ref); // ���� �׷�
				pstmt.setInt(2, re_step); // ��� �޸� ����
				pstmt.executeUpdate();
				re_step=re_step+1; // ��� �޸� ������ 1 �þ
				re_level=re_level+1; // ���� ���� ���° ������� ��Ÿ��
			}else{ //�����϶�
				ref=number;
				re_step=0; // �����̹Ƿ� ��� ����
				re_level=0; // 0�� ����
			}


			//�������� ������ �ֱ� insert into ���̺�� values (��������.NEXTVAL,'��'); 
			sql = "insert into board(num,writer,email,subject,passwd,reg_date,";
			sql+="ref,re_step,re_level,content,ip) values(board_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
				
			pstmt = conn.prepareStatement(sql);
				
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	}
	
	
	
	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x=0;  // Data Ȯ�� ����� ��Ʈ���ϱ� ���� x���� 
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from board");
			//select count(*) from �� ��ü ������ ���ڵ� ���� ����
			rs = pstmt.executeQuery(); //��ü ��ȸ �������� ����  ������ ��ȯ
			if (rs.next()) { //�� �Խñ��� ������ Ȯ��
				x= rs.getInt(1); //�Խñ��� ������ �ϳ��� ������
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

	
	// �Խ��� �� ��� ����
	public List getArticles(int start, int end) throws Exception 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //select ���� ����� ��� ��
		List articleList=null;
		try 
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(
					// start�� end�� �����Ͽ� ref�� ������������ , re_step�� ������������ �����Ѵ�
					"select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
					+
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r " +
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount " +
					"from board order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? ");
	 
					pstmt.setInt(1, start); 
					pstmt.setInt(2, end); 

					rs = pstmt.executeQuery();//prepareStatement ��ü�� SQL�� �����Ͽ� ������ ResultSet ��� ���� ���� ��
					if (rs.next()) 
					{
						articleList = new ArrayList(end); //ArrayList ũ�⸦ end ��ŭ �����Ѵ�
						do
						{ 
							BoardDataBean article= new BoardDataBean(); 
							  // BoardDataBean ��ü ���� �÷� ���� �ϳ��� �����ͼ�, ����Ÿ�� ��ü�� �־ ArrayList�� ���
							article.setNum(rs.getInt("num"));
							article.setWriter(rs.getString("writer"));
							article.setEmail(rs.getString("email"));
							article.setSubject(rs.getString("subject"));
							article.setPasswd(rs.getString("passwd"));
							article.setReg_date(rs.getTimestamp("reg_date"));
							article.setReadcount(rs.getInt("readcount"));
							article.setRef(rs.getInt("ref"));
							article.setRe_step(rs.getInt("re_step"));
							article.setRe_level(rs.getInt("re_level"));
							article.setContent(rs.getString("content"));
							article.setIp(rs.getString("ip"));
							
							articleList.add(article); // BoardDataBean ��  ���� articleList.add�� ����ó��
						}
						while(rs.next());
					}
		} 
		catch(Exception ex) 
		{
			ex.printStackTrace();
		}
		finally 
		{
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}		
		return articleList;
	}
	
	
//�Խ���  ���� ��� ���� �߰�
	public List getmyArticles(int start, int end, String id) throws Exception 
	{ /*�α��� �ø� ������ �� �ֵ��� id�� ������ �޴´�*/
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //select ���� ����� ��� ��
		List articleList=null;
		try 
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(
					// start�� end�� �����Ͽ� ref�� ������������ , re_step�� ������������ �����Ѵ�
					"select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
					+
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r " +
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount " +
					"from where writer=? order by reg_date) order by ref desc, re_step asc ) where r >= ? and r <= ? ");
	 
					pstmt.setInt(1, start); 
					pstmt.setInt(2, end); 

					rs = pstmt.executeQuery();//prepareStatement ��ü�� SQL�� �����Ͽ� ������ ResultSet ��� ���� ���� ��
					if (rs.next()) 
					{
						articleList = new ArrayList(end); //ArrayList ũ�⸦ end ��ŭ �����Ѵ�
						do
						{ 
							BoardDataBean article= new BoardDataBean(); 
							  // BoardDataBean ��ü ���� �÷� ���� �ϳ��� �����ͼ�, ����Ÿ�� ��ü�� �־ ArrayList�� ���
							article.setNum(rs.getInt("num"));
							article.setWriter(rs.getString("writer"));
							article.setEmail(rs.getString("email"));
							article.setSubject(rs.getString("subject"));
							article.setPasswd(rs.getString("passwd"));
							article.setReg_date(rs.getTimestamp("reg_date"));
							article.setReadcount(rs.getInt("readcount"));
							article.setRef(rs.getInt("ref"));
							article.setRe_step(rs.getInt("re_step"));
							article.setRe_level(rs.getInt("re_level"));
							article.setContent(rs.getString("content"));
							article.setIp(rs.getString("ip"));
							
							articleList.add(article); // BoardDataBean ��  ���� articleList.add�� ����ó��
						}
						while(rs.next());
					}
		} 
		catch(Exception ex) 
		{
			ex.printStackTrace();
		}
		finally 
		{
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}

		
		return articleList;
	}
	
	// �Խ��� �� ���� ����
		public BoardDataBean getArticle(int num) throws Exception 
		{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardDataBean article=null;
			try
			{
				conn = getConnection();
				pstmt = conn.prepareStatement(
				"update board set readcount=readcount+1 where num = ?"); //��ȸ�� �������� ����
				pstmt.setInt(1, num); //������ ��ȸ�� set
				pstmt.executeUpdate(); // ������ ��ȸ���� �����ͺ��̽��� ����, ��� ����
				pstmt = conn.prepareStatement(
				"select * from board where num = ?"); // num�� �ش��ϴ� ���ڵ带 �ҷ��´�
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) 
				{
					article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
				}
			} 
			catch(Exception ex) 
			{
				ex.printStackTrace();
			}
			finally 
			{
				if (rs != null) try { rs.close(); } catch(SQLException ex) {}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {}
			}
			
			return article;
		}
		
	
	public BoardDataBean updateGetArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
			"select * from board where num = ?"); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}

		return article;
	}
	

	public int updateArticle(BoardDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String dbpasswd="";
		String sql="";
		int x=-1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
			"select passwd from board where num = ?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(article.getPasswd())){
					sql="update board set writer=?,email=?,subject=?,passwd=?";
					sql+=",content=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getPasswd());
					pstmt.setString(5, article.getContent());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate();
					x= 1;
				}else{
					x= 0;
				}
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
	

	public int deleteArticle(int num, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String dbpasswd="";
		int x=-1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
			"select passwd from board where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("passwd");
				if(dbpasswd.equals(passwd)){
					pstmt = conn.prepareStatement(
					"delete from board where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x= 1; 
				}else
					x= 0; 
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

public int pwchArticle(int num, String passwd) throws Exception { //��й�ȣ Ȯ��
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs= null;
	String dbpasswd="";
	int x=-1;
	try {
		conn = getConnection();
		pstmt = conn.prepareStatement(
		"select passwd from board where num = ?");
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		if(rs.next()){
			dbpasswd= rs.getString("passwd");
			if(dbpasswd.equals(passwd)){
				x= 1; 
			}else
				x= 0; 
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
}



