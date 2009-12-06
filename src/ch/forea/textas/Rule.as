package ch.forea.textas{

  public class Rule{
    
    private var _context:Object;
    private var _command:String;
    private var _conditions:Vector.<Function>;
    private var _actions:Vector.<Function>;
    
    public function Rule(context:Object, command:String, conditions:Vector.<Function>, actions:Vector.<Function>){
      _context = context;
      _command = command;
      _conditions = conditions;
      _actions = actions;
    }
    
    public function calculate(command:String):void{
      if(command == _command){
	var l:uint = _conditions.length;
	for(var i:uint=0;i<l;i++){
	  if(!_conditions[i].call(_context)){
	    return;
	  }
	}
	l = _actions.length;
        for(i=0;i<l;i++){
          _actions[i].call(_context);
        }
      }
    }

  }

}