package Comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CommentDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CommentDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:ORCL";
			String dbID = "system";
			String dbPW = "1234";
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
//			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL", "system", "1234");
		} catch (ClassNotFoundException e) {
            System.out.println("Oracle JDBC Driver not found");
            e.printStackTrace();
            
		} catch (SQLException e) {
			System.out.println("Connection failed");
			e.printStackTrace();
		}
	}
	
	public String getDate() { // 시간 가져오기
		String SQL = "SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB오류
	}
	
	public int getNext() { // 다음으로 작성될 게시글ID
		String SQL = "SELECT id FROM jspComments ORDER BY id DESC";
		
		try (PreparedStatement pstmt = conn.prepareStatement(SQL);
	             ResultSet rs = pstmt.executeQuery()){
			
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 현재가 첫번째 게시물일때
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류
	}
	
	public ArrayList<Comment> getComments(int boardId) {
	    String SQL = "SELECT id, board_id, title, createTime FROM jspComments WHERE board_id = ? ORDER BY createTime DESC";
	    ArrayList<Comment> list = new ArrayList<Comment>();
	    try {
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, boardId);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Comment comment = new Comment();
	            comment.setId(rs.getInt("id"));
	            comment.setBoard_id(rs.getInt("board_id"));
	            comment.setTitle(rs.getString("title"));
	            comment.setCreateTime(rs.getString("createTime"));
	            list.add(comment);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public int addComment(Comment comment) { // 게시글 등록
		String SQL = "INSERT INTO jspComments (id, board_id, title, pw, createTime) VALUES (?, ?, ?, ?, TO_TIMESTAMP(?, 'YYYY-MM-DD HH24:MI:SS'))";
		
		try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, comment.getBoard_id());
			pstmt.setString(3, comment.getTitle());
			pstmt.setString(4, comment.getPw());
			pstmt.setString(5, getDate());
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류
	}
	
	public int deleteComment(Comment comment) {
	    String SQL = "DELETE FROM jspComments WHERE id = ? AND pw = ?";
	    
	    try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
	        pstmt.setInt(1, comment.getId());
	        pstmt.setString(2, comment.getPw());
	        
	        return pstmt.executeUpdate();
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return -1; // 삭제 실패
	}
}
