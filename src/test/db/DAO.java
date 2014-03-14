package test.db;

import java.sql.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.util.*;


public class DAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private DAO(){} //싱글인스턴스 방식 생성자(하나만 쓸것이므로 private로 접근제어)
	private static DAO dao = new DAO(); // dao 생성
	public static DAO getInstance(){ 
		return dao;
	}
	/*커넥션 연결*/
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	/*레코드 단위의 dto 생성하기 */
	public ArrayList<DTO> select(){ // 레코드를 리스트화해서 jbdc 서버에 넘기기
		ArrayList<DTO> list = new ArrayList<DTO>(); // 목록생성 (<DTO> 지정 제너릭은 타입을 제한하기 위한것)
		try{			
			conn = getConnection(); 
			pstmt = conn.prepareStatement("select*from test");
			rs = pstmt.executeQuery();
			while(rs.next()){
				DTO dto = new DTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setAge(rs.getInt("age")+"");// +""를 써주면 문자로 형변환된다.
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{ //종료
			try {rs.close();} catch (SQLException e){}
			try {pstmt.close();} catch (SQLException e){}
			try {conn.close();} catch (SQLException e){}
		}
		return list;
	}
	/*insert 하기*/
	public void insert(DTO dto){
		try{
			conn = getConnection(); //연결			
			String sql="insert into test values(?,?,?,sysdate)"; // 쿼리 던지기
			pstmt = conn.prepareStatement(sql); // 자료 준비단계
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			int age = Integer.parseInt(dto.getAge());
			pstmt.setInt(3, age);
			pstmt.executeUpdate(); // 실행
			}catch(Exception e){
				e.printStackTrace();
			}finally{ // 닫기
				try { pstmt.close();} catch (SQLException e){}
				try { conn.close();} catch (SQLException e){}
			}
	}
	public void update(){		
	}
	public void delete(){		
	}

	/*로그인 체크*/
	public boolean loginCh(String id, String pw){ 
		boolean result = false;
		try{
			conn = getConnection(); //커넥션 연결
			String sql="select id,pw from test where id=? and pw=?"; //DB의 id, pw와 비교확인
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery(); // 쿼리 실행
			/*레코드에서 검색결과 확인*/
			if(rs.next()){ // 
				result = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{ //종료
			try {rs.close();} catch (SQLException e){}
			try {pstmt.close();} catch (SQLException e){}
			try {conn.close();} catch (SQLException e){}
		}
		return result;
		}
		
	}

