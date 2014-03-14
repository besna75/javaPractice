package image;	//시퀀스를 대처하는 테이블 작성 시퀀스와 똑같은 기능을 한다.

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Sequencer {
    public synchronized static int nextId(Connection conn, String tableName) 
    throws SQLException {
        PreparedStatement pstmtSelect = null;
        ResultSet rsSelect = null;
        
        PreparedStatement pstmtUpdate = null;
        
        try {
            pstmtSelect = conn.prepareStatement(
            "select MESSAGE_ID from ID_SEQUENCE where TABLE_NAME = ?");
            pstmtSelect.setString(1, tableName);
            
            rsSelect = pstmtSelect.executeQuery();
            
            /*테이블 이름과 관련된 MESSAGE_ID 가 존재할경우의 처리
             * MESSAGE_ID 값을 ID 변수에 저장후 MESSAGE_ID 값을 1증가시킨다 그럼후 ID 값을 리턴한다. 
             * */
            if (rsSelect.next()) {
                int id = rsSelect.getInt(1);
                id++;
                
                pstmtUpdate = conn.prepareStatement(
                  "update ID_SEQUENCE set MESSAGE_ID = ? "+
                  "where TABLE_NAME = ?");
                pstmtUpdate.setInt(1, id);
                pstmtUpdate.setString(2, tableName);
                pstmtUpdate.executeUpdate();
                
                return id;
            /*테이블 이름과 관련된 MESSAGE_ID 가 존재하지않을경우  처리
             * 해당 테이블에 MESSAGE_ID 필드의 값을 1로지정한 레코드를추가 그런후 1을 리턴한다.
             * */
            } else {
                pstmtUpdate = conn.prepareStatement(
                "insert into ID_SEQUENCE values (?, ?)");
                pstmtUpdate.setString(1, tableName);
                pstmtUpdate.setInt(2, 1);
                pstmtUpdate.executeUpdate();
                
                return 1;
            }
        } finally {
            if (rsSelect != null) 
                try { rsSelect.close(); } catch(SQLException ex) {}
            if (pstmtSelect != null) 
                try { pstmtSelect.close(); } catch(SQLException ex) {}
            if (pstmtUpdate != null) 
                try { pstmtUpdate.close(); } catch(SQLException ex) {}
        }
    }
}

