package ch.forea.textas{

  public class Rule{
    
    private var _context:Object;
    private var _command:String;
    private var _conditions:Vector.<Function>;
    private var _actions:Vector.<Function>;
    
    public function Rule(context:Object, command:String, conditions:Array, actions:Array){
      _context = context;
      _command = command;
      _conditions = Vector.<Function>(conditions);
      _actions = Vector.<Function>(actions);
    }
    
    public function test(command:String):Boolean{
      if(command == _command){
	var l:uint = _conditions.length;
	for(var i:uint = 0; i < l; i++){
	  if(!_conditions[i].call(_context)){
	    return false;
	  }
        }
        l = _actions.length;
        for(i = 0; i < l; i++){
          _actions[i].call(_context);
        }
        return true;
      }
      return false;
    }

  }

}