package model;



public class Post {
	
	public int postID;
	public String userName;
	public int threadID;
	public int parentPostID;
	public int votes;
	public String content;
	public String dateTime;
	
	public Post(int postID, String userName, int threadID, 
			int parentPostID, int votes, String content, String dateTime)
	{
		this.postID = postID;
		this.userName = userName;
		this.threadID = threadID;
		this.parentPostID = parentPostID;
		this.votes = votes;
		this.content = content;
		this.dateTime = dateTime;
		
	}

	
	
	
}
