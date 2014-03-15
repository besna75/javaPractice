package board;
import java.sql.*;

import javax.sql.*;
import javax.naming.*;

import java.util.*; 

public class BoardDBBean {
	/* �̱������� ����ϴ� Ŭ������ ����� ��ü ���� ��ƾ�� ����(�ν��Ͻ��� �ϳ� ����� �� ��, ���뿡 Ȱ�� )*/ 

	 private static BoardDBBean instance = new BoardDBBean(); // 2. instance ��� static ������ �ʱ�ȭ �Ѵ�.  
	    public static BoardDBBean getInstance() { //3. getInstance��� �޼ҵ忡 ���ؼ� ��� ���� �ν��Ͻ��� ��ȯ
	        return instance; 
	    } 

	    private BoardDBBean()  { } //1. �����ڸ� private�� �����.(�Ǽ��� �Ǵٸ� �ν��Ͻ� �����ϴ� ���� ��������)

	    /*Ŀ�ؼ� ����*/  
	    private Connection getConnection() throws Exception { 

	    /* Obtain our environment naming context
				  1. �ʱ� ��Ȳ���� setting : �ʱ�ȯ�� ������ API�� InitialContext�� ��� �� initCtx�� ���
				  2. ��Ȳ���� �ڿ� �������� : �����ÿ� ������ ��Ʈ���� ���ҽ� �����Ͽ� ȯ�汸üȭ �� envCtx�� ���
				  3. DB���� �ڿ��������� : DataSource�� �����Ͽ� DB �ڿ� �������� �� ds�� ���
				  									 "jdbc/orcl"�� web.xml�� context.xml�� �����Ǿ� �ִ� name��
				  4. Ŀ�ؼ�Ǯ�κ��� ����ȹ���Ͽ� return�ϱ�
		  */
	    	
	      Context initCtx = new InitialContext(); //1. �ʱ� ��Ȳ���� setting 
	      Context envCtx = (Context) initCtx.lookup("java:comp/env"); //2. ��Ȳ���� �ڿ� ��������
	      DataSource ds = (DataSource)envCtx.lookup("jdbc/orcl"); // 3. DB���� �ڿ���������
	      return ds.getConnection(); // 4. Ŀ�ؼ�Ǯ�κ��� ����ȹ��
	    }
	
		/* Board Method List 
		 * Method-1.�۰��� getArticleCount()	 
		 * Method-2.�۸�� List getArticles(int start, int end)
		 * Method-3.��й�ȣ Ȯ�� int pwchArticle(int num, String passwd)
		 * Method-4.�۳��� BoardDataBean getArticle(int num)
		 * Method-5.���Է� insertArticle(BoardDataBean article
		 * Method-6.�ۼ��� BoardDataBean updateGetArticle(int num)	 
		 * Method-7.�ۻ��� int deleteArticle(int num, String passwd)		 *  
		/* add Method
		 * add Method-1.���۰���  int getMyArticleCount(String id)
		 * add Method-2.���۸�� List getmyArticles(int start, int end, String id) 
		 * add Method-3.�ۼ���(�н�����Ȯ��) int updateArticle(BoardDataBean article) */	    
	 /* �����ؾ� �� ���� List
	  * article : ��õ ������ (1. write.jsp�� ���Ͽ� ����� �� 2.content.jsp���� num�� �Ű������� �Ͽ� db���� �ҷ��� ��)*/

	    
/* Method-1. �۰���  */	    
	  	public int getArticleCount() throws Exception {
	  		Connection conn = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null;
	  		int x=0;  // Data Ȯ�� ����� ��Ʈ���ϱ� ���� x���� 
	  		
	  		try {
	  			conn = getConnection();
	  			pstmt = conn.prepareStatement(
	  					"select count(*) from board"); //�� ��ü ������ ���ڵ� ���� ����
	  			rs = pstmt.executeQuery(); //���� ����(��ü ��ȸ �������� ����  ���� ��ȯ�ޱ�)
	  			if (rs.next()) { //�� �Խñ��� ������ Ȯ��
	  				x= rs.getInt(1); //�Խñ��� ����(���� ���� �� SQL�� ù��° column�� ��) ����
	  			}
	  		} catch(Exception ex) {
	  			ex.printStackTrace();
	  		} finally {
	  			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	  			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	  			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	  		}
	  		return x; 
	  	}	// Method-1. end  
	  	
	  	
/* Method-2.�۸�� */ 
	  	public List getArticles(int start, int end) throws Exception {
	  		Connection conn = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null; //���� ���� ����� ��� ��
	  		List articleList=null;
	  		try 
	  		{
	  			conn = getConnection();
	  			pstmt = conn.prepareStatement( //PreparedStatement : �������� �������� ȿ�������� �����ϱ� ���Ͽ� ����Ѵ�.
	  					/* ���� ó������ : ref�� �����������İ� re_step�� �������� ���� �� ���ȣ(rownum r)���� �� ���� �� db���� ���*/	 
	  					"select num,writer,email,subject,passwd,reg_date,ref,re_step,page_step,content,ip,readcount,r " +
	  					 
	  					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,page_step,content,ip,readcount,rownum r " +
	  					// 2. rownum r ���� �� �����Ѵ�.(rownum�� SQL ��ɾ�� ���ȣ�� �������ش�)
	  					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,page_step,content,ip,readcount " + 
	  					"from board order by ref desc, re_step asc) "
	  					// 1. start�� end�� �����Ͽ� ref�� ������������ , re_step�� ������������ �����Ѵ�	  					
	  					+ "order by ref desc, re_step asc ) where r >= ? and r <= ? ");
	  					// 3. ����(where r >= ? and r <= ?)��  ���� ����
	  			
	  					pstmt.setInt(1, start); //setInt (int parameterIndex, int x)
	  					pstmt.setInt(2, end); 

	  					rs = pstmt.executeQuery();//prepareStatement ��ü�� SQL�� �����Ͽ� ������ ResultSet ��� ���� ���� ��
	  					if (rs.next()) {  						
	  						/* ó������ : db���� �÷� �� ���������stack�� �޸𸮡浥��Ÿ�� ��ü article�� �ֱ��ArrayList�� ��� */	  						
	  						articleList = new ArrayList(end); //ArrayList ũ�⸦ end ��ŭ �����Ѵ�
	  						do{ 
	  							BoardDataBean article= new BoardDataBean(); 	  							
	  							article.setNum(rs.getInt("num"));
	  							article.setWriter(rs.getString("writer"));
	  							article.setEmail(rs.getString("email"));
	  							article.setSubject(rs.getString("subject"));
	  							article.setPasswd(rs.getString("passwd"));
	  							article.setReg_date(rs.getTimestamp("reg_date"));
	  							article.setReadcount(rs.getInt("readcount"));
	  							article.setRef(rs.getInt("ref"));
	  							article.setRe_step(rs.getInt("re_step"));
	  							article.setPage_step(rs.getInt("page_step"));
	  							article.setContent(rs.getString("content"));
	  							article.setIp(rs.getString("ip"));	  							
	  							articleList.add(article); // BoardDataBean ��  ���� articleList.add�� ����ó��
	  						}
	  						while(rs.next());
	  					}
	  		} 
	  		catch(Exception ex) {
	  			ex.printStackTrace();
	  		}
	  		finally {
	  			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	  			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	  			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	  		}		
	  		return articleList;
	  	} // Method-2. end  
 	
/* Method-3.��й�ȣ Ȯ�� */	  	
	  	public int pwchArticle(int num, String passwd) throws Exception { //��й�ȣ Ȯ��
	  		Connection conn = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs= null;
	  		String dbpasswd="";		  		
	  		int x=-1;	  		
	  		try {
	  			conn = getConnection(); //������ �ڿ� ����
	  			pstmt = conn.prepareStatement("select passwd from board where num = ?"); //�ʿ� ������ ��ȸ setting
	  			pstmt.setInt(1, num); //
	  			rs = pstmt.executeQuery(); //���� ���� �� ��ȯ	  			
	  			if(rs.next()){
	  				dbpasswd= rs.getString("passwd"); //db���� ��ȸ�Ͽ� ������ ���� dbpasswd�� �ְ�			
	  					if(dbpasswd.equals(passwd)){ // ���� passwd�� ��
	  						x= 1; // ������ 1	
	  				}else
	  					x= 0; // �ٸ��� 0
	  			}
	  		} catch(Exception ex) {
	  			ex.printStackTrace();
	  		} finally {
	  			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	  			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	  			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	  		}
	  		return x;
	  	} // Method-3. end  
	  	
/* Method-4.�۳��� : ��ȸ��, �ش緹�ڵ��� db�ڿ� �޸� */	  	
			public BoardDataBean getArticle(int num) throws Exception { 
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				BoardDataBean article=null; 
				try	{
					conn = getConnection();
					pstmt = conn.prepareStatement(
					"update board set readcount=readcount+1 where num = ?"); //��ȸ�� �������� ����
					pstmt.setInt(1, num); //������ ��ȸ�� set
					pstmt.executeUpdate(); // ������ ��ȸ���� �����ͺ��̽��� ����, ��� ����
					pstmt = conn.prepareStatement("select * from board where num = ?"); // num�� �ش��ϴ� ���ڵ带 �ҷ��´�
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					
					if (rs.next()){
						article = new BoardDataBean(); //BoardDataBean�� �����Ͽ� article ��ü ����
						article.setNum(rs.getInt("num"));
						article.setWriter(rs.getString("writer"));
						article.setEmail(rs.getString("email"));
						article.setSubject(rs.getString("subject"));
						article.setPasswd(rs.getString("passwd"));
						article.setReg_date(rs.getTimestamp("reg_date"));
						article.setReadcount(rs.getInt("readcount"));
						article.setRef(rs.getInt("ref"));
						article.setRe_step(rs.getInt("re_step"));
						article.setPage_step(rs.getInt("page_step"));
						article.setContent(rs.getString("content"));
						article.setIp(rs.getString("ip"));
					}
				} 
				catch(Exception ex) {
					ex.printStackTrace();
				}
				finally{
					if (rs != null) try { rs.close(); } catch(SQLException ex) {}
					if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
					if (conn != null) try { conn.close(); } catch(SQLException ex) {}
				}				
				return article;
			} // Method-4. end  
			
/* Method-5.���Է� */			
			public void insertArticle(BoardDataBean article) throws Exception {//�� writePro.jsp
				/*db�ڿ��� ���踦 ���� �� �������� �ʵ弱��*/
				Connection conn = null; //���ᰪ �ʱ�ȭ
				PreparedStatement pstmt = null; // Query�� ���� pstmt ���� �� �ʱ�ȭ
				ResultSet rs = null; // ResultSet (�����ͺ��̽��� ������ ���� ����� ��������)
				/*�ʿ� �������� ��������*/
				int num = article.getNum(); // ���� ������ȣ
				int ref = article.getRef(); // ���� �׷�
				int re_step = article.getRe_step(); //���� page_step �۵��� ����
				int page_step = article.getPage_step(); //�� �켱���� 0-���� , 1-��� , 2-����� ���
				int FirstNum = 0; //���ʱ� ��ȣ
				/*���� ���� ����*/
				String sql="";
				
				try {
					conn = getConnection(); //Ŀ�ؼ� Ǯ�� ����
					pstmt = conn.prepareStatement("select max(num) from board"); // board���̺��� �ִ밪 
					rs = pstmt.executeQuery();//���� ����
					
					if (rs.next())
						FirstNum=rs.getInt(1)+1; //���� ���� ���� �������۹�ȣ+1 [getInt(1)-column�� ù��° �����Ǿ� �ִ� Int�� ��������]	
					else
						FirstNum=1; // ���ʱ� ��ȣ
					
					if (num!=0) {// ������ �ƴҶ�			 
						sql="update board set re_step = re_step+1 where ref = ? and re_step > ?";		//����� level ����				
						pstmt = conn.prepareStatement(sql);
						
						pstmt.setInt(1, ref); // ���� �׷�
						pstmt.setInt(2, re_step); // ����� level
						pstmt.executeUpdate();
						
						re_step=re_step+1; // ��� �޸� ������ 1 �þ
						page_step=page_step+1; // ���� ���� ���° ������� ��Ÿ��
						
					}else{ //�����϶�
						ref=FirstNum; 
						re_step=0; // �����̹Ƿ� ��� ����
						page_step=0; // 0�� ����
					}


					//�������� ������ �ֱ� insert into ���̺�� values (��������.NEXTVAL,'��'); 
					sql = "insert into board(num,writer,email,subject,passwd,reg_date,";
					sql+= "ref,re_step,page_step,content,ip) values(board_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
						
					pstmt = conn.prepareStatement(sql);
						
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getPasswd());
					pstmt.setTimestamp(5, article.getReg_date());
					pstmt.setInt(6, ref);
					pstmt.setInt(7, re_step);
					pstmt.setInt(8, page_step);
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
			} // Method-5. end  
			
/* Method-6.�ۼ���  */
	  	
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
	  				article.setPage_step(rs.getInt("page_step"));
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
	  	} // Method-6. end 
	
			
/* Method-7.�ۻ��� */
	public int deleteArticle(int num, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String dbpasswd="";
		int x=-1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from board where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("passwd");
				if(dbpasswd.equals(passwd)){
					pstmt = conn.prepareStatement("delete from board where num=?");
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
	} // Method-7. end  


	/*add Method*/

	/* add Method-1. ���۰���  */	
	public int getMyArticleCount(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
	"select count(*) from board where writer=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x; 
	}// add Method-1. end	  
	
/* add Method-2.���۸�� */
	public List getMyArticles(int start, int end,String id) throws Exception {/*�α��� �ø� ������ �� �ֵ��� id�� ������ �޴´�*/
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select num,writer,email,subject,passwd,reg_date,ref,re_step,page_step,content,ip,readcount,r "+
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,page_step,content,ip,readcount,rownum r " +
					"from (select * from board where writer=? order by reg_date) order by reg_date ) where r >= ? and r <= ? ");
					// writer=?
					pstmt.setString(1, id);
					pstmt.setInt(2, start); 
					pstmt.setInt(3, end); 

					rs = pstmt.executeQuery();
					if (rs.next()) {
						articleList = new ArrayList(end); 
						do{ 
							BoardDataBean article= new BoardDataBean();
							article.setNum(rs.getInt("num"));
							article.setWriter(rs.getString("writer"));
							article.setEmail(rs.getString("email"));
							article.setSubject(rs.getString("subject"));
							article.setPasswd(rs.getString("passwd"));
							article.setReg_date(rs.getTimestamp("reg_date"));
							article.setReadcount(rs.getInt("readcount"));
							article.setRef(rs.getInt("ref"));
							article.setRe_step(rs.getInt("re_step"));
							article.setPage_step(rs.getInt("page_step"));
							article.setContent(rs.getString("content"));
							article.setIp(rs.getString("ip"));
							articleList.add(article); 
						}while(rs.next());
					}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}

		
		return articleList;
	} // add Method-2. end  
	
/* add Method-3.�ۼ���(�н�����Ȯ��) */
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
			"select passwd from board where num = ?"); //�۹�ȣ�� Ű�� �Ͽ� �н����� �����ϰڴٴ� ������
			pstmt.setInt(1, article.getNum()); //�۹�ȣ �غ�
			rs = pstmt.executeQuery(); //���� ����
			
			if(rs.next()){
				dbpasswd= rs.getString("passwd"); //db�� �Էµ� passed�� ��Ȯ��
				if(dbpasswd.equals(article.getPasswd())){//db�� �Էµ� passed�� ���� ��
					sql="update board set writer=?,email=?,subject=?,passwd=?";
					sql+=",content=? where num=?"; //�������� �۹�ȣ ����							
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getPasswd());
					pstmt.setString(5, article.getContent());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate(); //db�� ������Ʈ
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
	} // add Method-3. end  
	
} // class BoardDBBean ����



