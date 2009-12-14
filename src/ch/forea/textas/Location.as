package ch.forea.textas{

  import __AS3__.vec.Vector;

  public class Location{

    private var _title:String = "";
    private var _description:String = "";
    private var _exits:Vector.<Exit> = new Vector.<Exit>;
    private var _rules:Vector.<Rule> = new Vector.<Rule>;

    public function Location(title:String = "NO TITLE", description:String = "NO DESCRIPTION"){
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

    public function addRule(rule:Rule):void{
      _rules.push(rule);
    }

    public function removeRule(rule:Rule):void{
      if(_rules.indexOf(rule) > -1){
	_rules = _rules.splice(_rules.indexOf(rule), 1);
      }
    }

    public function get rules():Vector.<Rule>{
      return _rules.concat();
    }

    public function get exits():Vector.<Exit>{
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
