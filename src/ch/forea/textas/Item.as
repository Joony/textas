package ch.forea.textas{

  public class Item{
    
    private static const REPLACE_TOKEN:RegExp = /<<[A-z0-9]*>>/;
    private static const TOKEN:RegExp = /[\w ,.]*<<([A-z0-9]*)>>[\w ,.<<>>]*/

    private var _keyword:String;
    private var _shortDescription:String;
    private var _longDescription:String;
    private var _location:Location;
    private var _variables:Object;
    
    public function Item(keyword:String = "NO_KEYWORD", shortDescription:String = "NO SHORT DESCRIPTION", longDescription:String = "NO LONG DESCRIPTION", location:Location = null, variables:Object = null){
      _keyword = keyword;
      _shortDescription = shortDescription;
      _longDescription = longDescription;
      _location = location
      _variables = variables;
    }

    public function get keyword():String{
      return _keyword;
    }

    public function get shortDescription():String{
      return _shortDescription;
    }

    public function get longDescription():String{
      var tempDescription:String = _longDescription;;
      var tempToken:String;
      while(REPLACE_TOKEN.test(tempDescription)){
	tempToken = tempDescription.replace(TOKEN, "$1");
	trace("tempToken = " + tempToken);
	tempDescription = tempDescription.replace(REPLACE_TOKEN, _variables[tempToken]);
      }
      return tempDescription;
    }

    public function get location():Location{
      return _location;
    }

    private function getVar(v:String):void{
      trace("v = " + v);
    }

  }

}
