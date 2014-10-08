package model;

import java.util.Comparator;

public class ThreadAlphaComparator implements Comparator<Object>{
	

		private static ThreadAlphaComparator curr = null;
		
		private ThreadAlphaComparator(){}
		
		public static ThreadAlphaComparator getInstance()
		{
			if(curr == null)
			{
				curr = new ThreadAlphaComparator();
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
			
			    String t1description = t1.description;
			    String t2description = t2.description;
			    
			    return t1description.compareToIgnoreCase(t2description);
			
			
			
		}
		
	

}
