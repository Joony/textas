package ch.forea.textas{

  public class World{
    
    public var score:uint = 0;
    public var gold:uint = 0;

    public var location0_vars:Object = {};
    
    public var currentLocation:Location;
    
    private var _directions:Vector.<String> = Vector.<String>(["NORTH", "SOUTH", "EAST", "WEST", "UP", "DOWN"]);
    private var _verbs:Vector.<String> = Vector.<String>(["LOOK", "SWITCH", "TURN"]);
    private var _nouns:Vector.<String> = Vector.<String>(["ON", "OFF", "LIGHT", "LIGHTS"]);
    
    private var _rules:Vector.<Rule> = new Vector.<Rule>;

    public function get directions():Vector.<String>{
      return _directions.concat();
    }
    public function get verbs():Vector.<String>{
      return _verbs.concat();
    }
    public function get nouns():Vector.<String>{
      return _nouns.concat();
    }
    public function get rules():Vector.<Rule>{
      return _rules.concat();
    }
    public function testDirection(direction:String):Boolean{
      var exits:Vector.<Exit> = currentLocation.exits;
      var l:uint = exits.length;
      for(var i:uint = 0; i < l; i++){
	if(direction == exits[i].directionName){
	  currentLocation = exits[i].leadsTo;
	  return true;
	}
      }
      return false;
    }
    public function World(){
      
      var location0:Location = new Location("DARK ROOM", "IT IS TOO DARK TO SEE ANYTHING");
      var location1:Location = new Location("WARDROBE", "YOU ARE STANDING IN A TINY DARK ROOM.  THE ONLY LIGHT IS FROM ROOM YOU CAME FROM.  CLOTHES ARE HANGING ALL AROUND YOU AND SHOES LITTER THE FLOOR.");
      var location2:Location = new Location("HALLWAY", "YOU ARE STANDING OUTSIDE YOUR APPARTMENT.  2673.  THE DOOR IS WIDE OPEN AND YOU CAN SEE THE SMELL ESCAPING.");

      location0.addExit(new Exit(Exit.NORTH, location1));
      location0.addExit(new Exit(Exit.EAST, location2));
      location1.addExit(new Exit(Exit.SOUTH, location0));
      location2.addExit(new Exit(Exit.WEST, location0));

      currentLocation = location0;

      var location0_vars:Object = {lightsOn:false};
      
      var condition0_0:Function = function():Boolean{return !location0_vars["lightsOn"] ? true : false};
      var condition0_1:Function = function():Boolean{return location0_vars["lightsOn"] ? true : false};

      var action0_2:Function = function():void{
	location0_vars["lightsOn"] = true;
	currentLocation.description = "THE LIGHT IS ON, BUT YOU'D PREFER IF IT WASN'T.  THE ROOM IS A GRIMEY MESS.  KIBBLE SEEMS TO HAVE TAKEN OVER.  THERE IS A DOOR LEADING NORTH AND A ROOM TO THE EAST.";
	trace("THE LIGHT BULB FLICKERS DIMLY IN TO EXISTENCE.  THE ROOM DOESN'T LOOK LIKE IT'S BEEN LIVED IN FOR YEARS.  AFTER A MOMENT, YOU REALISE THAT THIS IS YOUR APPARTMENT.");
      };
      location0.addRule(new Rule(this, ["TURN ON LIGHT", "TURN ON LIGHTS", "SWITCH ON LIGHT", "SWITCH ON LIGHTS"], [condition0_0], [action0_2]));

      var action0_3:Function = function():void{
        trace("THE LIGHTS ARE ALREADY ON.");
      };
      location0.addRule(new Rule(this, ["TURN ON LIGHT", "TURN ON LIGHTS", "SWITCH ON LIGHT", "SWITCH ON LIGHTS"], [condition0_1], [action0_3]));

      var action0_4:Function = function():void{
        location0_vars["lightsOn"] = false;
	currentLocation.description = "IT IS TOO DARK TO SEE ANYTHING";
        trace("THE ROOM IS PLUNGED BACK IN TO DARKNESS.");
      };
      location0.addRule(new Rule(this, ["TURN OFF LIGHT", "TURN OFF LIGHTS", "SWITCH OFF LIGHT", "SWITCH OFF LIGHTS"], [condition0_1], [action0_4]));

      var action0_5:Function = function():void{
	trace("THE LIGHTS ARE ALREADY OFF.");
      };
      location0.addRule(new Rule(this, ["TURN OFF LIGHT", "TURN OFF LIGHTS", "SWITCH OFF LIGHT", "SWITCH OFF LIGHTS"], [condition0_0], [action0_5]));

    }
  }

}
