package ch.forea.textas{

  import flash.display.Sprite;
  import flash.events.KeyboardEvent;
  import flash.utils.Dictionary;

  public class Main extends Sprite{

    private var currentLocation:Location;
    private var command:String = "";

    public function Main(){
      
      var location1:Location = new Location("Entrance to hall...", "You stand at the entrance of a long hallway. The hallway gets darker\nand darker, and you cannot see what lies beyond. To the east\nis an old oaken door, unlocked and beckonning");
      var location2:Location = new Location("End of hall...", "You have reached the end of a long dark hallway. You can\nsee nowhere to go but back");
      var location3:Location = new Location("Small study...", "This is a small and cluttered study, containing a desk covered with\npapers. Though they no doubt are of some importance,\nyou cannot read their writing");

      location1.addExit(new Exit(Exit.NORTH, location2));
      location1.addExit(new Exit(Exit.EAST, location3));
      location2.addExit(new Exit(Exit.SOUTH, location1));
      location3.addExit(new Exit(Exit.WEST, location1));

      currentLocation = location1;
      
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);

      showLocation();
    }

    private function keyDown(e:KeyboardEvent):void{
      if((e.keyCode >= 65 && e.keyCode <= 90) || e.keyCode == 32 || (e.keyCode >= 48 && e.keyCode <= 57)){
	command += String.fromCharCode(e.keyCode).toUpperCase();
      }else if(e.keyCode == 8 || e.keyCode == 46){
	command = command.slice(0, command.length - 1);
      }else if(e.keyCode == 13){
	action();
      }
      trace(command);
    }

    private function showLocation():void{
      trace("------------------------------------------------------------------");
      trace(currentLocation.title + " - " + currentLocation.description);
      var availableExits:String = currentLocation.exits.join(", ");
      trace("Available exits: " + availableExits);
    }


    // regex
    //private var verbNounPair:RegExp = /(?:.*?)(LOOK)(?:.*)/;
    
    // words
    private var directions:Array = ["NORTH", "SOUTH", "EAST", "WEST", "UP", "DOWN", "NORTHE", "NORTHW", "SOUTHE", "SOUTHW", "N", "S", "E", "W", "U", "D", "NE", "NW", "SE", "SW"];
    private var verbs:Array = ["LOOK", "L", "EXAMINE", "X", "USE", "U"];
    private var nouns:Array = ["BRANCHES", "TREE"];
    

    private function action():void{
      if(command.length == 0){
	return;
      }
      command = command.toUpperCase();
      

      var words:Array = command.split(" ");
      var foundWords:Array = [];
      var foundVerb:Boolean = false;
      var foundNouns:uint = 0;

      var l:uint = words.length;
      for(var i:uint=0;i<l;i++){
	if(!foundVerb && verbs.indexOf(words[i]) > -1){
	  trace("verb found:", words[i]);
	  foundWords.push(verbs.indexOf(words[i]));
	  foundVerb = true;
	}else if(foundVerb && foundNouns < 2 && nouns.indexOf(words[i]) > -1){
	  trace("noun found:", words[i]);
	  foundWords.push(nouns.indexOf(words[i]));
	  foundNouns++;
	}
      }

      if(!foundVerb){
	trace("I do not understand what you want to do.");
      }
      
      command = "";
      trace("foundWords:", foundWords);

      

      /*

      trace("verbNounPair = " + command.replace(verbNounPair, "$1 - $2"));
      var verb:String = command.replace(verbNounPair, "$1");
      if(verb && verbs[verb]){
	processVerb(verbs[verb]);
	command = "";
      }

      */

      /*
      var commands:Array = command.split(" ");
      if(directions.indexOf(command.substr(0, 6)) > -1){
	var exits:Array = currentLocation.exits;
	for each(var i:* in exits){
	    if(command == i.directionName || command == i.shortDirectionName){
	      currentLocation = i.leadsTo;
	      showLocation();
	      command = "";
	      return;
	    }
	}
      }
      trace("Huh? Invalid direction!");
      command = "";
      */
    }

    private function processVerb(verb:uint):void{
      switch(verb){
        case 0:
	  trace("You would like to look at something?");
	break;
        case 1:
	  trace("You would like to examine something?");
	break;
        case 2:
        case 3:
        case 4:
        case 5:
	  trace("Goodbye!");
	  stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
	break;
	  
      }
    }
    

  }

}
