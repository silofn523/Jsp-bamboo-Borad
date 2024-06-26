package Board;

public class Board {
	
	private int id;
	private String title;
	private String content;
	private String name;
	private String pw;
	private String createTime;
	
	// ID
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	// 제목
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	//내용
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	//작성자
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	//PW
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	//생성일자
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
