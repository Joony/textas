package ch.forea.textas{

  public class Rule{
    
    private var _commands:Vector.<String>;
    private var _conditions:Vector.<Function>;
    private var _actions:Vector.<Function>;
    
    private static var _context:Object;

    public function Rule(commands:Array, conditions:Array, actions:Array){
      _commands = Vector.<String>(commands);
      _conditions = Vector.<Function>(conditions);
      _actions = Vector.<Function>(actions);
    }

    public static function set context(context:Object):void{
      _context = context;
    }
    
    public function test(command:String):Boolean{
      var l0:uint = _commands.length;
      for(var i:uint = 0; i < l0; i++){
        if(compareCommands(command, _commands[i]) && testConditions()){
	  return executeActions(command);
        }
      }
      return false;
    }

    private function compareCommands(input:String, rule:String):Boolean{
      if(rule.indexOf("*") == -1){
	return input == rule;
      }else{
	var tempInputCommand:Array = input.split(" ");
	var tempRuleCommand:Array = rule.split(" ");
	//TODO: Maybe check the length of both commands to make sure they're the same.
	var l:uint = tempInputCommand.length;
        for(var i:uint = 0; i < l; i++){
	  if((!tempRuleCommand[i] || tempRuleCommand[tempRuleCommand.length-1] != "*") && tempRuleCommand[i] != "*" && tempInputCommand[i] != tempRuleCommand[i]){
	    return false;
	  }
	}
      }
      return true;
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