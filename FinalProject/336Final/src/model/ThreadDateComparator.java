package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;

public class ThreadDateComparator implements Comparator<Object>{

	public static ThreadDateComparator curr = null;
	
	private ThreadDateComparator(){}
	
	public static ThreadDateComparator getInstance()
	{
		if(curr == null)
		{
			curr = new ThreadDateComparator();
		}
		
		return curr;
	}
	
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
		    
		    Date date1 = null;
		    Date date2 = null;
		    
		    try{
		    
		   date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(t1.dateTime);
		   date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(t2.dateTime);
		    
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
