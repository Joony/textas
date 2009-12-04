package ch.forea.textas{

  public class Location{

    private var _title:String = "";
    private var _description:String = "";
    private var _exits:Array = [];
    
    public function Location(title:String = "", description:String = ""){
      _title = title;
      _description = description;
    }

    public function toString():String{
      return title;
    }

    public function addExit(exit:Exit):void{
      _exits.push(exit);
    }

    public function removeExit(exit:Exit):void{
      if(_exits.indexOf(exit) > -1){
	_exits = _exits.splice(_exits.indexOf(exit), 1);
      }
    }

    public function get exits():Array{
      return _exits.concat();
    }

    public function get title():String{
      return _title;
    }

    public function set title(title:String):void{
      _title = title;
    }

    public function get description():String{
      return _description;
    }

    public function set description(description:String):void{
      _description = description;
    }

  }

}
