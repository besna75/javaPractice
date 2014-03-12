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
		PreparedStatement pstmt = null; // Query를 담을 pstmt 선언 및 초기화
		ResultSet rs = null; // ResultSet (데이터베이스에 쿼리를 날린 결과를 가져오기)
		
		int num = article.getNum(); // 글의 고유번호
		int ref = article.getRef(); // 글의 그룹
		int re_step = article.getRe_step(); // 답글 달린 순서
		int re_level = article.getRe_level(); //글 우선순위 0-새글 , 1-답글 , 2-답글의 답글
		int number = 0; 
		
		String sql="";
		
		try {
			conn = getConnection(); 
			pstmt = conn.prepareStatement("select max(num) from board"); // board테이블에서 최대값 
			rs = pstmt.executeQuery();//쿼리 실행
			
			if (rs.next())
				number=rs.getInt(1)+1;	// 0+1=1:답글   ,   1+1=2:답글의 답글
			else
				number=1; // 답글
			
			if (num!=0) // 새글이 아닐때
			{ 
				sql="update board set re_step = re_step+1 where ref = ? and re_step > ?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, ref); // 글의 그룹
				pstmt.setInt(2, re_step); // 답글 달린 순서
				pstmt.executeUpdate();
				re_step=re_step+1; // 답글 달린 순서가 1 늘어남
				re_level=re_level+1; // 현재 글이 몇번째 답글인지 나타냄
			}else{ //새글일때
				ref=number;
				re_step=0; // 새글이므로 답글 없음
				re_level=0; // 0은 새글
			}


			//시퀀스의 증가값 넣기 insert into 테이블명 values (시퀀스명.NEXTVAL,'값'); 
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
		int x=0;  // Data 확인 결과를 컨트롤하기 위한 x선언 
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from board");
			//select count(*) from → 전체 데이터 레코드 갯수 세기
			rs = pstmt.executeQuery(); //전체 조회 데이터의 현재  갯수를 반환
			if (rs.next()) { //총 게시글의 갯수를 확인
				x= rs.getInt(1); //게시글의 갯수를 하나로 보여줌
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

	
	// 게시판 글 목록 보기
	public List getArticles(int start, int end) throws Exception 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //select 실행 결과를 담는 곳
		List articleList=null;
		try 
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(
					// start와 end로 제한하여 ref는 내림차순으로 , re_step은 오름차순으로 정렬한다
					"select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
					+
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r " +
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount " +
					"from board order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? ");
	 
					pstmt.setInt(1, start); 
					pstmt.setInt(2, end); 

					rs = pstmt.executeQuery();//prepareStatement 객체의 SQL을 실행하여 생성된 ResultSet 결과 값을 돌려 줌
					if (rs.next()) 
					{
						articleList = new ArrayList(end); //ArrayList 크기를 end 만큼 생성한다
						do
						{ 
							BoardDataBean article= new BoardDataBean(); 
							  // BoardDataBean 객체 생성 컬럼 값을 하나씩 가져와서, 데이타빈 객체에 넣어서 ArrayList에 담기
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
							
							articleList.add(article); // BoardDataBean 의  값을 articleList.add로 묶음처리
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
	
	
//게시판  내글 목록 보기 추가
	public List getmyArticles(int start, int end, String id) throws Exception 
	{ /*로그인 시만 보여줄 수 있도록 id도 변수로 받는다*/
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //select 실행 결과를 담는 곳
		List articleList=null;
		try 
		{
			conn = getConnection();
			pstmt = conn.prepareStatement(
					// start와 end로 제한하여 ref는 내림차순으로 , re_step은 오름차순으로 정렬한다
					"select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
					+
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r " +
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount " +
					"from where writer=? order by reg_date) order by ref desc, re_step asc ) where r >= ? and r <= ? ");
	 
					pstmt.setInt(1, start); 
					pstmt.setInt(2, end); 

					rs = pstmt.executeQuery();//prepareStatement 객체의 SQL을 실행하여 생성된 ResultSet 결과 값을 돌려 줌
					if (rs.next()) 
					{
						articleList = new ArrayList(end); //ArrayList 크기를 end 만큼 생성한다
						do
						{ 
							BoardDataBean article= new BoardDataBean(); 
							  // BoardDataBean 객체 생성 컬럼 값을 하나씩 가져와서, 데이타빈 객체에 넣어서 ArrayList에 담기
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
							
							articleList.add(article); // BoardDataBean 의  값을 articleList.add로 묶음처리
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
	
	// 게시판 글 내용 보기
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
				"update board set readcount=readcount+1 where num = ?"); //조회수 증가시켜 저장
				pstmt.setInt(1, num); //증가된 조회수 set
				pstmt.executeUpdate(); // 증가된 조회수를 데이터베이스에 변경, 결과 보기
				pstmt = conn.prepareStatement(
				"select * from board where num = ?"); // num에 해당하는 레코드를 불러온다
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

public int pwchArticle(int num, String passwd) throws Exception { //비밀번호 확인
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



