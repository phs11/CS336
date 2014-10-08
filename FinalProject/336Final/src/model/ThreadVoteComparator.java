package model;

import java.util.Comparator;

public class ThreadVoteComparator implements Comparator<Object>{

	public static ThreadVoteComparator curr = null;
	
	private ThreadVoteComparator(){}
	
	public static ThreadVoteComparator getInstance()
	{
		if(curr == null)
		{
			curr = new ThreadVoteComparator();
		}
		
		return curr;
	}

	@Override
	public int compare(Object o1, Object o2) {
		
		 if (o1 == null && o2 == null) return 0;
		    // assuming you want null values shown last
		    if (o1 != null && o2 == null) return -1;
		    if (o1 == null && o2 != null) return 1;
		    if (!(o1 instanceof Thread) ||
		        !(o2 instanceof Thread)) {
		      throw new IllegalArgumentException ("...");
		    }
		    
		    Thread t1 = (Thread) o1;
		    Thread t2 = (Thread) o2;
		
		    int t1Votes = t1.votes;
		    int t2Votes = t2.votes;
		    
		    if(t1Votes > t2Votes)
		    	return -1;
		    if(t1Votes < t2Votes)
		    	return 1;
		    else
		    	return 0;
		    
		
		
		
	}
	
}
