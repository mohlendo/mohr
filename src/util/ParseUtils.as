package util
{
  import mx.controls.HTML;
  
	public class ParseUtils
	{
	  private static const urlPattern:RegExp = /(http[s]?:\/\/[^\s]+)(\s?)/g
	  
	  private static const tagPattern:RegExp = /#(\S+)/g
	  
	  private static const userPattern:RegExp = /@(\S+)/g
	  
	  
	  //Tue Aug 05 11:09:41 +0000 2008
		public static function calcInterval(value:String):String
	  {
	    var dateArray:Array = value.split(' ');
	    var createdAt:Date = new Date(Date.parse( dateArray[0] + ', ' + dateArray[2] + ' ' + dateArray[1] + ' ' + dateArray[3] + ' ' + dateArray[5].substring(0,4) ));
	    
	    var interval:Number = new Date().getTime() - createdAt.getTime();
	    var sec:int = (interval / 1000);
	    if(sec >0 && sec <= 59)
	      return "about "+sec+" sec ago";
	
	    var min:int = sec / 60;
	    if (min > 0 && min <= 59)
	      return "about "+min+" min ago";
	
	    var hours:int = min / 60;
	    if (hours >0 && hours <=24)
	      return "about "+hours+" h ago";
	      	
	    return createdAt.toLocaleString();
	  }
	  
	  public static function formatText(value:String):String
	  {
	    return value.replace(urlPattern,"<font color=\"#0099ff\"><a href=\"$1\">$1</a></font>$2").replace(tagPattern, "<font color=\"#0099ff\"><a href=\"https://trillr.coremedia.com/tags/$1\">#$1</a></font>").replace(userPattern, "<font color=\"#0099ff\"><a href=\"https://trillr.coremedia.com/$1\">@$1</a></font>");
	  }	  
	}
}