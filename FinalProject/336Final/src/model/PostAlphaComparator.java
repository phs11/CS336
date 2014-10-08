package model;

import java.util.Comparator;

public class PostAlphaComparator implements Comparator<Object>{
	

		private static PostAlphaComparator curr = null;
		
		private PostAlphaComparator(){}
		
		public static PostAlphaComparator getInstance()
		{
			if(curr == null)
			{
				curr = new PostAlphaComparator();
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
			
			    String p1Content = p1.content;
			    String p2Content = p2.content;
			    
			    return p1Content.compareToIgnoreCase(p2Content);
			
			
			
		}
		
	

}
