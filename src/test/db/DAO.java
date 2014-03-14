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
	private DAO(){} //�̱��ν��Ͻ� ��� ������(�ϳ��� �����̹Ƿ� private�� ��������)
	private static DAO dao = new DAO(); // dao ����
	public static DAO getInstance(){ 
		return dao;
	}
	/*Ŀ�ؼ� ����*/
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	/*���ڵ� ������ dto �����ϱ� */
	public ArrayList<DTO> select(){ // ���ڵ带 ����Ʈȭ�ؼ� jbdc ������ �ѱ��
		ArrayList<DTO> list = new ArrayList<DTO>(); // ��ϻ��� (<DTO> ���� ���ʸ��� Ÿ���� �����ϱ� ���Ѱ�)
		try{			
			conn = getConnection(); 
			pstmt = conn.prepareStatement("select*from test");
			rs = pstmt.executeQuery();
			while(rs.next()){
				DTO dto = new DTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setAge(rs.getInt("age")+"");// +""�� ���ָ� ���ڷ� ����ȯ�ȴ�.
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{ //����
			try {rs.close();} catch (SQLException e){}
			try {pstmt.close();} catch (SQLException e){}
			try {conn.close();} catch (SQLException e){}
		}
		return list;
	}
	/*insert �ϱ�*/
	public void insert(DTO dto){
		try{
			conn = getConnection(); //����			
			String sql="insert into test values(?,?,?,sysdate)"; // ���� ������
			pstmt = conn.prepareStatement(sql); // �ڷ� �غ�ܰ�
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			int age = Integer.parseInt(dto.getAge());
			pstmt.setInt(3, age);
			pstmt.executeUpdate(); // ����
			}catch(Exception e){
				e.printStackTrace();
			}finally{ // �ݱ�
				try { pstmt.close();} catch (SQLException e){}
				try { conn.close();} catch (SQLException e){}
			}
	}
	public void update(){		
	}
	public void delete(){		
	}

	/*�α��� üũ*/
	public boolean loginCh(String id, String pw){ 
		boolean result = false;
		try{
			conn = getConnection(); //Ŀ�ؼ� ����
			String sql="select id,pw from test where id=? and pw=?"; //DB�� id, pw�� ��Ȯ��
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery(); // ���� ����
			/*���ڵ忡�� �˻���� Ȯ��*/
			if(rs.next()){ // 
				result = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{ //����
			try {rs.close();} catch (SQLException e){}
			try {pstmt.close();} catch (SQLException e){}
			try {conn.close();} catch (SQLException e){}
		}
		return result;
		}
		
	}

