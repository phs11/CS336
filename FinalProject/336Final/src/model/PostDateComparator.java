package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;

public class PostDateComparator implements Comparator<Object>{

	public static PostDateComparator curr = null;
	
	private PostDateComparator(){}
	
	public static PostDateComparator getInstance()
	{
		if(curr == null)
		{
			curr = new PostDateComparator();
		}
		
		return curr;
	}
	
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
		    
		    Date date1 = null;
		    Date date2 = null;
		    
		    try{
		    
		   date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(p1.dateTime);
		   date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(p2.dateTime);
		    
		    }
		    catch (ParseException e)
		    {
		    	
		    	
		    	
		    }
		    //old
		    if(date1.before(date2))
		    	return 1;
		    //new
		    if(date2.before(date1))
		    	return -1;
		    //equal
		    else
		    	return 0;
		    
		
		
		
	}
	

}
