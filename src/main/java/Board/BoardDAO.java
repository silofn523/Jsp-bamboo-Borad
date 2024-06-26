package Board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BoardDAO() {
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
		String SQL = "SELECT id FROM jspBoard ORDER BY id DESC";
		
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
	
	public int write(Board Board) { // 게시글 등록
		String SQL = "INSERT INTO jspBoard (id, title, content, name, pw, createTime) VALUES (?, ?, ?, ?, ?, TO_TIMESTAMP(?, 'YYYY-MM-DD HH24:MI:SS'))";
		
		try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
			pstmt.setInt(1, getNext());
			pstmt.setString(2, Board.getTitle());
			pstmt.setString(3, Board.getContent());
			pstmt.setString(4, Board.getName());
			pstmt.setString(5, Board.getPw());
			pstmt.setString(6, getDate());
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류
	}
	
	public ArrayList<Board> getList(int pageNumber) { // 게시글 전체 조회
	    int pageSize = 10; // 페이지당 표시할 게시물 수
	    int start = (pageNumber - 1) * pageSize; // 시작 위치 계산
	    String SQL = "SELECT * FROM (SELECT rownum as rnum, id, title, content, name, createTime FROM (SELECT id, title, content, name, createTime FROM jspBoard ORDER BY id DESC)) WHERE rnum BETWEEN ? AND ?";
	    ArrayList<Board> list = new ArrayList<Board>();

	    try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
	        pstmt.setInt(1, start + 1); // 시작 위치 설정
	        pstmt.setInt(2, start + pageSize); // 종료 위치 설정
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Board board = new Board();
	            board.setId(rs.getInt("id"));
	            board.setTitle(rs.getString("title"));
	            board.setContent(rs.getString("content"));
	            board.setName(rs.getString("name"));
	            board.setCreateTime(rs.getString("createTime"));

	            list.add(board);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public boolean nextPage(int pageNumber) { // 게시글이 일정 수가 넘었을 떄 대충 다음 페이지 넘어가게 하는거
	    int pageSize = 10; // 페이지당 표시할 게시물 수
	    int start = (pageNumber - 1) * pageSize; // 시작 위치 계산
	    String SQL = "SELECT id FROM (SELECT id FROM jspBoard ORDER BY id DESC) WHERE ROWNUM <= ? AND ROWNUM >= ?";
	    
	    try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
	        pstmt.setInt(1, start + pageSize); // 시작 위치 설정
	        pstmt.setInt(2, start + 1); // 종료 위치 설정
	        rs = pstmt.executeQuery();
	        
	        return rs.next(); // 다음 페이지가 있는지 여부 반환
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public Board getBoard(int id) {
	    String SQL = "SELECT * FROM jspBoard WHERE id = ?";
	    
	    try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
	        pstmt.setInt(1, id); 
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	        	Board board = new Board();
	            board.setId(rs.getInt("id"));
	            board.setTitle(rs.getString("title"));
	            board.setContent(rs.getString("content"));
	            board.setName(rs.getString("name"));
	            board.setPw(rs.getString("pw"));
	            board.setCreateTime(rs.getString("createTime"));
	            return board;
			}
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	public int updateBoard(Board board) {
	    String SQL = "UPDATE jspBoard SET title = ?, content = ? WHERE id = ?";
	    
	    try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
	        pstmt.setString(1, board.getTitle());
	        pstmt.setString(2, board.getContent());
	        pstmt.setInt(3, board.getId());
	        return pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return -1; // 데이터베이스 오류
	}
	
	public int deleteBoard(int id) {
        try {
            // 댓글 먼저 삭제
            deleteCommentsByBoardId(id);
            
            // 게시물 삭제
            String SQL = "DELETE FROM jspBoard WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
                pstmt.setInt(1, id);
                return pstmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    
    // 새로 추가할 댓글 삭제 메서드
    public void deleteCommentsByBoardId(int boardId) throws SQLException {
        String SQL = "DELETE FROM jspComments WHERE board_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, boardId);
            pstmt.executeUpdate();
        }
    }
	
	public ArrayList<Board> searchBoard(String title, String name) {
	    String SQL = "SELECT * FROM jspBoard WHERE title LIKE ? AND name LIKE ?";
	    ArrayList<Board> list = new ArrayList<Board>();
	    
	    try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
	        pstmt.setString(1, "%" + title + "%");
	        pstmt.setString(2, "%" + name + "%");
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Board board = new Board();
	            board.setId(rs.getInt("id"));
	            board.setTitle(rs.getString("title"));
	            board.setContent(rs.getString("content"));
	            board.setName(rs.getString("name"));
	            board.setPw(rs.getString("pw"));
	            board.setCreateTime(rs.getString("createTime"));
	            list.add(board);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}


}
