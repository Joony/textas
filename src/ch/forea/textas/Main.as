package ch.forea.textas{

  import flash.display.Sprite;
  import flash.events.KeyboardEvent;
  import flash.utils.Dictionary;
  import __AS3__.vec.Vector;

  public class Main extends Sprite{

    private var world:World = new World();
    private var inputString:String = "";

    public function Main(){
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
      showLocation();
    }

    private function keyDown(e:KeyboardEvent):void{
      if((e.keyCode >= 65 && e.keyCode <= 90) || e.keyCode == 32 || (e.keyCode >= 48 && e.keyCode <= 57)){
	inputString += String.fromCharCode(e.keyCode).toUpperCase();
      }else if(e.keyCode == 8 || e.keyCode == 46){
	inputString = inputString.slice(0, inputString.length - 1);
      }else if(e.keyCode == 13){
	action();
      }
      trace(inputString);
    }

    private function showLocation():void{
      trace("------------------------------------------------------------------");
      trace(world.currentLocation.title);
      trace(world.currentLocation.description);
      var availableExits:String = world.currentLocation.exits.join(", ");
      trace("Available exits: " + availableExits);
    }
    
    
    private function action():void{
      if(inputString.length == 0){
	return;
      }
      inputString = inputString.toUpperCase();
      
      var words:Array = inputString.split(" ");
      var foundWords:String;
      var foundVerb:Boolean = false;
      var foundNouns:uint = 0;

      var l:uint = words.length;
      for(var i:uint=0;i<l;i++){
	if(!foundVerb && world.directions.indexOf(words[i]) > -1){
	  trace("direction found:", words[i]);
	  if(world.testDirection(words[i])){
	    inputString = "";
	    showLocation();
	  }
	  return;
	}else if(!foundVerb && world.verbs.indexOf(words[i]) > -1){
	  trace("verb found:", words[i]);
	  foundWords = words[i];
	  foundVerb = true;
	}else if(foundVerb && foundNouns < 2 && world.nouns.indexOf(words[i]) > -1){
	  trace("noun found:", words[i]);
	  foundWords += " " + words[i];
	  foundNouns++;
	}
      }

      if(!foundVerb){
	trace("I do not understand what you want to do.");
	inputString = "";
	return;
      }
      
      if(foundWords == "LOOK"){
	showLocation();
	inputString = "";
	return;
      }

      var rules:Vector.<Rule> = world.rules;
      l = rules.length;
      for(i = 0; i < l; i++){
        if(rules[i].test(foundWords)){
          inputString = "";
          return;
        }
      }

      rules = world.currentLocation.rules;
      l = rules.length;
      for(i = 0; i < l; i++){
	if(rules[i].test(foundWords)){
	  inputString = "";
	  return;
        }
      }
      
    }

  }

}
