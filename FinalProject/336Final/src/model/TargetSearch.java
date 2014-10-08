package model;

public class TargetSearch {
	
	public static boolean checkMatch(String search, String str){
		search = search.toLowerCase();
		str = str.toLowerCase();
		String[] words = search.split(" ");
		for(int i=0; i < words.length; i++){
			if(str.contains(removeNonAlpha(words[i]))){
				return true;
			}
		}
		return false;
		
	}
	private static String removeNonAlpha(String s){ 
		String result = "";
		for (int i = 0; i < s.length(); i++) {
			if (Character.isLetter(s.charAt(i))) {
				result = result.concat(s.charAt(i) + "");
			}
		}
		return result;
	}
	
}
