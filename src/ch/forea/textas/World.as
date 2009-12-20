package ch.forea.textas{

  public class World{
    
    public var score:uint = 0;
    public var euros:uint = 0;

    public var inventory:Object = {};
    
    public var currentLocation:Location;
    
    private var _directions:Vector.<String> = Vector.<String>(["NORTH", "SOUTH", "EAST", "WEST", "UP", "DOWN"]);
    private var _verbs:Vector.<String> = Vector.<String>(["LOOK", "EXAMINE", "SWITCH", "TURN", "PICK", "GET", "OPEN"]);
    private var _nouns:Vector.<String> = Vector.<String>(["UP", "ON", "OFF", "LIGHT", "LIGHTS", "SHOE", "SHOES", "KIPPLE", "EYES", "DOOR"]);
    
    private var _rules:Vector.<Rule> = new Vector.<Rule>;
    
    private var write:Function;
    private var showLocation:Function;
    
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



    public function World(write:Function, showLocation:Function){

      this.write = write;
      this.showLocation = showLocation;
      
      var location0:Location = new Location("DARK ROOM", "IT IS TOO DARK TO SEE ANYTHING.");
      var location1:Location = new Location("TINY DARK ROOM", "YOU ARE STANDING IN A TINY DARK ROOM.  THE ONLY LIGHT IS FROM ROOM YOU CAME FROM.  CLOTHES ARE HANGING ALL AROUND YOU AND SHOES LITTER THE FLOOR.");
      var location2:Location = new Location("HALLWAY", "YOU ARE STANDING OUTSIDE YOUR APPARTMENT.  NUMBER 2673/B.  THE DOOR IS WIDE OPEN AND YOU CAN SEE THE SMELL ESCAPING.");
      // EXITS

      location1.addExit(new Exit(Exit.SOUTH, location0));
      location2.addExit(new Exit(Exit.WEST, location0));

      currentLocation = location0;
      


      
      // LOCATION 0 - YOUR APPARTMENT

      var location0_vars:Object = {lightsOn:false, north:new Exit(Exit.NORTH, location1), east:new Exit(Exit.EAST, location2)};
      
      var condition0_0:Function = function():Boolean{return !location0_vars.lightsOn ? true : false}; // if lights are off
      var condition0_1:Function = function():Boolean{return location0_vars.lightsOn ? true : false}; // if lights are on

      var action0_2:Function = function():void{
	location0_vars.lightsOn = true;
	currentLocation.title = "YOUR APPARTMENT";
	currentLocation.description = "YOU KNOCK A FEW THINGS OVER WHILE YOU FUMBLE AROUND LOOKING FOR THE LIGHT SWITCH.  THE LIGHT BULB FLICKERS DIMLY IN TO EXISTENCE.  THE ROOM DOESN'T LOOK LIKE IT'S BEEN LIVED IN FOR YEARS.  AFTER A MOMENT, YOU REALISE THAT THIS IS YOUR APPARTMENT. THERE IS A SMALL ROOM TO THE NORTH AND A DOOR TO THE EAST.";
	location0.addExit(location0_vars.north);
	showLocation();
	currentLocation.description = "THE LIGHT IS ON, BUT YOU'D PREFER IF IT WASN'T.  THE ROOM IS A GRIMEY MESS.  KIPPLE SEEMS TO HAVE TAKEN OVER.  THERE IS A SMALL ROOM TO THE NORTH AND A DOOR TO THE EAST.";
      };
      location0.addRule(new Rule(this, ["TURN ON LIGHT", "TURN ON LIGHTS", "SWITCH ON LIGHT", "SWITCH ON LIGHTS"], [condition0_0], [action0_2]));

      var action0_3:Function = function():void{
        write("THE LIGHTS ARE ALREADY ON.");
      };
      location0.addRule(new Rule(this, ["TURN ON LIGHT", "TURN ON LIGHTS", "SWITCH ON LIGHT", "SWITCH ON LIGHTS"], [condition0_1], [action0_3]));

      var action0_4:Function = function():void{
        location0_vars.lightsOn = false;
	location0.removeExit(location0_vars.north);
	currentLocation.title = "YOUR DARK APPARTMENT";
	currentLocation.description = "THE ROOM IS PLUNGED BACK IN TO DARKNESS.";
	showLocation();
	currentLocation.description = "IT IS TOO DARK TO SEE ANYTHING";
      };
      location0.addRule(new Rule(this, ["TURN OFF LIGHT", "TURN OFF LIGHTS", "SWITCH OFF LIGHT", "SWITCH OFF LIGHTS"], [condition0_1], [action0_4]));

      var action0_5:Function = function():void{
	write("THE LIGHTS ARE ALREADY OFF.");
      };
      location0.addRule(new Rule(this, ["TURN OFF LIGHT", "TURN OFF LIGHTS", "SWITCH OFF LIGHT", "SWITCH OFF LIGHTS"], [condition0_0], [action0_5]));
      
      var action0_6:Function = function():void{
	write("KIPPLE IS USELESS OBJECTS, LIKE JUNK MAIL OR MATCH FOLDERS AFTER YOU USE THE LAST MATCH OR GUM WRAPPERS OR YESTERDAY'S HOMEOPAPE.  WHEN NOBODY'S AROUND, KIPPLE REPRODUCES ITSELF.  FOR INSTANCE, IF YOU GO TO BED LEAVING ANY KIPPLE AROUND YOUR APPARTMENT, WHEN YOU WAKE UP THERE IS TWICE AS MUCH OF IT.  IT ALWAYS GETS MORE AND MORE.  THERE'S THE FIRST LAW OF KIPPLE \"KIPPLE DRIVES OUT NONKIPPLE.\"");
      };
      location0.addRule(new Rule(this, ["LOOK KIPPLE", "EXAMINE KIPPLE"], [], [action0_6]));

      var action0_7:Function = function():void{
	write("YOU OPEN YOUR EYES AND GIVE THEM A RUB.  IT'S STILL DARK.");
      };
      location0.addRule(new Rule(this, ["OPEN EYES"], [condition0_0], [action0_7]));

      var action0_8:Function = function():void{
	write("THE DOOR REFUSES TO OPEN.  IT SAYS, \"FIVE CENTS, PLEASE.\"");
      };
      location0.addRule(new Rule(this, ["OPEN DOOR"], [], [action0_8]));

      var action0_9:Function = function():void{
	write("A LARGE METAL DOOR MADE OF REINFORCED STEEL.  THERE DOESN'T APPEAR TO BE A HANDLE, BUT BESIDE THE DOOR THERE IS A SMALL COIN SLOT.");
      };
      location0.addRule(new Rule(this, ["LOOK DOOR", "EXAMINE DOOR"], [], [action0_9]));



      // LOCATION 1 - WARDROBE IN YOUR APPARTMENT
      
      var location1_vars:Object = {};

      var action1_0:Function = function():void{
	write("THERE ISN'T ENOUGH SPACE TO BEND OVER, BUT YOU WOULDN'T WANT TO ANYWAY, THE ODOUR IS QUITE PUNGENT, EVEN FROM UP HERE!");
      };
      location1.addRule(new Rule(this, ["LOOK SHOES", "LOOK SHOE", "EXAMINE SHOES", "EXAMINE SHOE"], [], [action1_0]));

      var action1_1:Function = function():void{
	write("NO.  I'M NOT TOUCHING THEM!");
      };
      location1.addRule(new Rule(this, ["GET SHOES", "GET SHOE", "PICK UP SHOES", "PICK UP SHOE"], [], [action1_1]));

      var action1_2:Function = function():void{
	
      };
      

      

      // LOCATION 2 - HALLWAY OUTSIDE YOUR APPARTMENT
      
    }
  }

}
