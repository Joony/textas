package ch.forea.textas{

  public class Rule{
    
    private var _context:Object;
    private var _commands:Vector.<String>;
    private var _conditions:Vector.<Function>;
    private var _actions:Vector.<Function>;
    
    public function Rule(context:Object, commands:Array, conditions:Array, actions:Array){
      _context = context;
      _commands = Vector.<String>(commands);
      _conditions = Vector.<Function>(conditions);
      _actions = Vector.<Function>(actions);
    }
    
    public function test(command:String):Boolean{
      var l0:uint = _commands.length;
      for(var i:uint = 0; i < l0; i++){
        if(command == _commands[i] && testConditions()){
	  return executeActions(command);
        }
      }
      return false;
    }

    /*
     * Test the conditions
     * returns true if the conditions pass and the Rule is true.
     */
    private function testConditions():Boolean{
      var l:uint = _conditions.length;
      for(var i:uint = 0; i < l; i++){
	if(!_conditions[i].call(_context)){
	  return false;
	}
      }
      return true;
    }

    private function executeActions(command:String):Boolean{
      var l:uint = _actions.length;
      for(var i:uint = 0; i < l; i++){
	if(_actions[i].length){
	  if(!_actions[i].call(_context, command)){
	    return false;
	  }
	}else{
	  _actions[i].call(_context);
	}
      }
      return true;
    }

  }

}