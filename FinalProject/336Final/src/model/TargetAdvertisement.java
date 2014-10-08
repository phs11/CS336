package model;

public class TargetAdvertisement {
	
	public static boolean checkMatch(String adKeywords, String post){
		String[] keywords = adKeywords.split(",");
		if(keywords.length > 0){
			for (int i = 0; i < keywords.length; i++) {
				if(post.contains(keywords[i].trim())){
					return true;
				}
			}
		}
		return false;
		
	}
	
	private String removeNonAlpha(String s){
		String result = "";
		for(int i=0; i<s.length(); i++){
			if(Character.isLetter(s.charAt(i))){
				result = result.concat(s.charAt(i) + "");
			}
		}
		return result;
	}
}
