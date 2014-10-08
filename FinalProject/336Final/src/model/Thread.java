package model;

public class Thread {
	
	public int threadID;
	public String topicName;
	public String dateTime;
	public int votes;
	public String description;
	
	
	public Thread(int threadID, String topicName, int votes, String description, String dateTime)
	{
		this.threadID = threadID;
		this.topicName = topicName;
		this.dateTime = dateTime;
		this.votes = votes;
		this.description = description;
		
		
	}

}
