package board;
import java.sql.*;

import javax.sql.*;
import javax.naming.*;

import java.util.*; 

public class BoardDBBean {
	/* 싱글턴으로 사용하는 클래스를 만들고 객체 생성 루틴을 구현(인스턴스를 하나 만들어 둔 후, 재사용에 활용 )*/ 

	 private static BoardDBBean instance = new BoardDBBean(); // 2. instance 라는 static 변수를 초기화 한다.  
	    public static BoardDBBean getInstance() { //3. getInstance라는 메소드에 의해서 계속 같은 인스턴스를 반환
	        return instance; 
	    } 

	    private BoardDBBean()  { } //1. 생성자를 private로 만든다.(실수로 또다른 인스턴스 생성하는 것을 막기위함)

	    /*커넥션 연결*/  
	    private Connection getConnection() throws Exception { 

	    /* Obtain our environment naming context
				  1. 초기 상황정보 setting : 초기환경 정보를 API인 InitialContext를 사용 → initCtx에 기억
				  2. 상황관련 자원 가져오기 : 웹어플에 구성된 엔트리와 리소스 참조하여 환경구체화 → envCtx에 기억
				  3. DB관련 자원가져오기 : DataSource를 참조하여 DB 자원 가져오기 → ds에 기억
				  									 "jdbc/orcl"은 web.xml과 context.xml에 설정되어 있는 name값
				  4. 커넥션풀로부터 연결획득하여 return하기
		  */
	    	
	      Context initCtx = new InitialContext(); //1. 초기 상황정보 setting 
	      Context envCtx = (Context) initCtx.lookup("java:comp/env"); //2. 상황관련 자원 가져오기
	      DataSource ds = (DataSource)envCtx.lookup("jdbc/orcl"); // 3. DB관련 자원가져오기
	      return ds.getConnection(); // 4. 커넥션풀로부터 연결획득
	    }
	
		/* Board Method List 
		 * Method-1.글갯수 getArticleCount()	 
		 * Method-2.글목록 List getArticles(int start, int end)
		 * Method-3.비밀번호 확인 int pwchArticle(int num, String passwd)
		 * Method-4.글내용 BoardDataBean getArticle(int num)
		 * Method-5.글입력 insertArticle(BoardDataBean article
		 * Method-6.글수정 BoardDataBean updateGetArticle(int num)	 
		 * Method-7.글삭제 int deleteArticle(int num, String passwd)		 *  
		/* add Method
		 * add Method-1.내글갯수  int getMyArticleCount(String id)
		 * add Method-2.내글목록 List getmyArticles(int start, int end, String id) 
		 * add Method-3.글수정(패스워드확인) int updateArticle(BoardDataBean article) */	    
	 /* 참조해야 할 변수 List
	  * article : 원천 데이터 (1. write.jsp를 통하여 저장된 것 2.content.jsp에서 num을 매개변수로 하여 db에서 불러온 것)*/

	    
/* Method-1. 글갯수  */	    
	  	public int getArticleCount() throws Exception {
	  		Connection conn = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null;
	  		int x=0;  // Data 확인 결과를 컨트롤하기 위한 x선언 
	  		
	  		try {
	  			conn = getConnection();
	  			pstmt = conn.prepareStatement(
	  					"select count(*) from board"); //→ 전체 데이터 레코드 갯수 세기
	  			rs = pstmt.executeQuery(); //쿼리 실행(전체 조회 데이터의 현재  갯수 반환받기)
	  			if (rs.next()) { //총 게시글의 갯수를 확인
	  				x= rs.getInt(1); //게시글의 갯수(쿼리 실행 → SQL의 첫번째 column의 값) 대입
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
	  	
	  	
/* Method-2.글목록 */ 
	  	public List getArticles(int start, int end) throws Exception {
	  		Connection conn = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null; //쿼리 실행 결과를 담는 곳
	  		List articleList=null;
	  		try 
	  		{
	  			conn = getConnection();
	  			pstmt = conn.prepareStatement( //PreparedStatement : 쿼리문을 여러차례 효율적으로 실행하기 위하여 사용한다.
	  					/* 쿼리 처리과정 : ref의 내림차순정렬과 re_step의 오름차순 정렬 → 행번호(rownum r)정의 및 정렬 → db정보 담기*/	 
	  					"select num,writer,email,subject,passwd,reg_date,ref,re_step,page_step,content,ip,readcount,r " +
	  					 
	  					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,page_step,content,ip,readcount,rownum r " +
	  					// 2. rownum r 정의 및 정렬한다.(rownum은 SQL 명령어로 행번호를 생성해준다)
	  					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,page_step,content,ip,readcount " + 
	  					"from board order by ref desc, re_step asc) "
	  					// 1. start와 end로 제한하여 ref는 내림차순으로 , re_step은 오름차순으로 정렬한다	  					
	  					+ "order by ref desc, re_step asc ) where r >= ? and r <= ? ");
	  					// 3. 범위(where r >= ? and r <= ?)에  따라 선택
	  			
	  					pstmt.setInt(1, start); //setInt (int parameterIndex, int x)
	  					pstmt.setInt(2, end); 

	  					rs = pstmt.executeQuery();//prepareStatement 객체의 SQL을 실행하여 생성된 ResultSet 결과 값을 돌려 줌
	  					if (rs.next()) {  						
	  						/* 처리과정 : db에서 컬럼 값 가져오기→stack에 메모리→데이타빈 객체 article에 넣기→ArrayList에 담기 */	  						
	  						articleList = new ArrayList(end); //ArrayList 크기를 end 만큼 생성한다
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
	  							articleList.add(article); // BoardDataBean 의  값을 articleList.add로 묶음처리
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
 	
/* Method-3.비밀번호 확인 */	  	
	  	public int pwchArticle(int num, String passwd) throws Exception { //비밀번호 확인
	  		Connection conn = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs= null;
	  		String dbpasswd="";		  		
	  		int x=-1;	  		
	  		try {
	  			conn = getConnection(); //데이터 자원 연결
	  			pstmt = conn.prepareStatement("select passwd from board where num = ?"); //필요 데이터 조회 setting
	  			pstmt.setInt(1, num); //
	  			rs = pstmt.executeQuery(); //쿼리 실행 및 반환	  			
	  			if(rs.next()){
	  				dbpasswd= rs.getString("passwd"); //db에서 조회하여 가져온 값을 dbpasswd에 넣고			
	  					if(dbpasswd.equals(passwd)){ // 받은 passwd와 비교
	  						x= 1; // 같으면 1	
	  				}else
	  					x= 0; // 다르면 0
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
	  	
/* Method-4.글내용 : 조회수, 해당레코드의 db자원 메모리 */	  	
			public BoardDataBean getArticle(int num) throws Exception { 
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				BoardDataBean article=null; 
				try	{
					conn = getConnection();
					pstmt = conn.prepareStatement(
					"update board set readcount=readcount+1 where num = ?"); //조회수 증가시켜 저장
					pstmt.setInt(1, num); //증가된 조회수 set
					pstmt.executeUpdate(); // 증가된 조회수를 데이터베이스에 변경, 결과 보기
					pstmt = conn.prepareStatement("select * from board where num = ?"); // num에 해당하는 레코드를 불러온다
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					
					if (rs.next()){
						article = new BoardDataBean(); //BoardDataBean을 참조하여 article 객체 생성
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
			
/* Method-5.글입력 */			
			public void insertArticle(BoardDataBean article) throws Exception {//→ writePro.jsp
				/*db자원의 연계를 통한 값 가져오기 필드선언*/
				Connection conn = null; //연결값 초기화
				PreparedStatement pstmt = null; // Query를 담을 pstmt 선언 및 초기화
				ResultSet rs = null; // ResultSet (데이터베이스에 쿼리를 날린 결과를 가져오기)
				/*필요 데이터의 변수선언*/
				int num = article.getNum(); // 글의 고유번호
				int ref = article.getRef(); // 글의 그룹
				int re_step = article.getRe_step(); //같은 page_step 글들의 구분
				int page_step = article.getPage_step(); //글 우선순위 0-새글 , 1-답글 , 2-답글의 답글
				int FirstNum = 0; //최초글 번호
				/*쿼리 변수 선언*/
				String sql="";
				
				try {
					conn = getConnection(); //커넥션 풀로 연결
					pstmt = conn.prepareStatement("select max(num) from board"); // board테이블에서 최대값 
					rs = pstmt.executeQuery();//쿼리 실행
					
					if (rs.next())
						FirstNum=rs.getInt(1)+1; //글이 있을 경우는 마지막글번호+1 [getInt(1)-column의 첫번째 지정되어 있는 Int값 가져오기]	
					else
						FirstNum=1; // 최초글 번호
					
					if (num!=0) {// 새글이 아닐때			 
						sql="update board set re_step = re_step+1 where ref = ? and re_step > ?";		//답글의 level 설정				
						pstmt = conn.prepareStatement(sql);
						
						pstmt.setInt(1, ref); // 글의 그룹
						pstmt.setInt(2, re_step); // 답글의 level
						pstmt.executeUpdate();
						
						re_step=re_step+1; // 답글 달린 순서가 1 늘어남
						page_step=page_step+1; // 현재 글이 몇번째 답글인지 나타냄
						
					}else{ //새글일때
						ref=FirstNum; 
						re_step=0; // 새글이므로 답글 없음
						page_step=0; // 0은 새글
					}


					//시퀀스의 증가값 넣기 insert into 테이블명 values (시퀀스명.NEXTVAL,'값'); 
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
			
/* Method-6.글수정  */
	  	
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
	
			
/* Method-7.글삭제 */
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

	/* add Method-1. 내글갯수  */	
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
	
/* add Method-2.내글목록 */
	public List getMyArticles(int start, int end,String id) throws Exception {/*로그인 시만 보여줄 수 있도록 id도 변수로 받는다*/
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
	
/* add Method-3.글수정(패스워드확인) */
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
			"select passwd from board where num = ?"); //글번호를 키로 하여 패스워드 선택하겠다는 쿼리문
			pstmt.setInt(1, article.getNum()); //글번호 준비
			rs = pstmt.executeQuery(); //쿼리 실행
			
			if(rs.next()){
				dbpasswd= rs.getString("passwd"); //db와 입력된 passed의 비교확인
				if(dbpasswd.equals(article.getPasswd())){//db와 입력된 passed가 같을 때
					sql="update board set writer=?,email=?,subject=?,passwd=?";
					sql+=",content=? where num=?"; //컨텐츠와 글번호 증가							
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getPasswd());
					pstmt.setString(5, article.getContent());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate(); //db의 업데이트
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
	
} // class BoardDBBean 종료



