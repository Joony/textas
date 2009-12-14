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
        if(command == _commands[i]){
	  var l1:uint = _conditions.length;
	  for(var j:uint = 0; j < l1; j++){
	    if(!_conditions[j].call(_context)){
	      return false;
	    }
	  }
	  l1 = _actions.length;
          for(j = 0; j < l1; j++){
            _actions[j].call(_context);
          }
	  return true;
        }
      }
      return false;
    }

  }

}