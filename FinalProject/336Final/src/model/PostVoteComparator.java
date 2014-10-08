package model;

import java.util.Comparator;

public class PostVoteComparator implements Comparator<Object>{

	public static PostVoteComparator curr = null;
	
	private PostVoteComparator(){}
	
	public static PostVoteComparator getInstance()
	{
		if(curr == null)
		{
			curr = new PostVoteComparator();
		}
		
		return curr;
	}

	@Override
	public int compare(Object o1, Object o2) {
		
		 if (o1 == null && o2 == null) return 0;
		    // assuming you want null values shown last
		    if (o1 != null && o2 == null) return -1;
		    if (o1 == null && o2 != null) return 1;
		    if (!(o1 instanceof Post) ||
		        !(o2 instanceof Post)) {
		      throw new IllegalArgumentException ("...");
		    }
		    
		    Post p1 = (Post) o1;
		    Post p2 = (Post) o2;
		
		    int p1Votes = p1.votes;
		    int p2Votes = p2.votes;
		    
		    if(p1Votes > p2Votes)
		    	return -1;
		    if(p1Votes < p2Votes)
		    	return 1;
		    else
		    	return 0;
		    
		
		
		
	}
	
}
