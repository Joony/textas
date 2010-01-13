package ch.forea.textas{

  public class World extends AbstractWorld{

    public var score:uint = 0;    
    
    public function World(write:Function, showLocation:Function){
      words = Vector.<Word>([
			     new Word("INVENTORY", Word.VERB, ["I"]),
			     new Word("VERSION", Word.VERB),
			     new Word("NORTH", Word.DIRECTION, ["N"]),
			     new Word("EAST", Word.DIRECTION, ["E"]),
			     new Word("SOUTH", Word.DIRECTION, ["S"]),
			     new Word("WEST", Word.DIRECTION, ["W"]),
			     new Word("UP", Word.DIRECTION, ["U"]),
		             new Word("DOWN", Word.DIRECTION, ["D"]),
		             new Word("TURN", Word.VERB, ["SWITCH"]),
		             new Word("ON", Word.NOUN),
		             new Word("OFF", Word.NOUN),
		             new Word("PICK", Word.VERB),
		             new Word("OPEN", Word.VERB),
		             new Word("LOOK", Word.VERB, ["L", "EXAMINE", "X"]),
		             new Word("TAKE", Word.VERB, ["G", "GET", "T", "PICK UP"]),
		             new Word("SHOE", Word.NOUN, ["SHOES", "SNEAKERS", "TRAINERS", "BOOTS"]),
		             new Word("CLOTHES", Word.NOUN),
		             new Word("SHIRT", Word.NOUN, ["SHIRTS"]),
		             new Word("LIGHT", Word.NOUN,["LIGHTS", "LAMP"]),
		             new Word("DOOR", Word.NOUN),
		             new Word("EYES", Word.NOUN, ["EYE"]),
		             new Word("KIPPLE", Word.NOUN, ["RUBBISH", "TRASH"]),
			     new Word("WRISTWATCH", Word.NOUN, ["WATCH"]),
			     new Word("COINS", Word.NOUN, ["MONEY"]),
			     new Word("TEST", Word.VERB)
                             ]);


      // LOCATIONS
      
      inventory = new Location();

      var location0:Location = new Location("DARK ROOM", "IT IS TOO DARK TO SEE ANYTHING.");
      var location1:Location = new Location("TINY DARK ROOM", "YOU ARE STANDING IN A TINY DARK ROOM.  THE ONLY LIGHT IS FROM ROOM YOU CAME FROM.  CLOTHES ARE HANGING ALL AROUND YOU AND SHOES LITTER THE FLOOR.");
      var location2:Location = new Location("HALLWAY", "YOU ARE STANDING OUTSIDE YOUR APPARTMENT.  NUMBER 2673/B.  THE NAME ON THE DOOR READS \"CHIP.\" THE DOOR IS WIDE OPEN AND YOU CAN SEE THE SMELL ESCAPING.");
      // EXITS

      location1.addExit(new Exit(Exit.SOUTH, location0));
      location2.addExit(new Exit(Exit.WEST, location0));

      currentLocation = location0;



      // ITEMS

      items = Vector.<Item>([
			     new Item("COINS", "<<amount>> CENTS IN COINS", "SOME LOOSE COINS THAT AMOUNT TO <<amount>> CENTS IN TOTAL", location0, {amount:75}),
			     new Item("WRISTWATCH", "YOUR WRISTWATCH", "CASIO, DIGITAL.  IT READS <<time>>", inventory, {time:function():String{return "7:28pm";}})
			     ]);

      
      



      

      // GLOBAL

      var action0:Function = function():void{
	write(version);
      };
      addRule(new Rule(this, ["VERSION"], [], [action0]));
      
      addRule(new Rule(this, ["LOOK"], [], [showLocation]));

      var action1:Function = function():void{
	write("YOU HAVE:");
	var item:Item;
	var inventoryItems:Vector.<Item> = new Vector.<Item>();
	for each(item in items){
	    trace("item = " + item, item.location, item.location == inventory);
	  if(item.location == inventory){
	    inventoryItems.push(item);
	  }
        }
	if(inventoryItems.length == 0){
	  write("NOTHING");
        }else{
          for each(item in inventoryItems){
            write(item.shortDescription + "\n");
          }
        }
      };
      addRule(new Rule(this, ["INVENTORY"], [], [action1]));

      var action2:Function = function():void{
	write("TEST: " + items[1].longDescription);
      };
      addRule(new Rule(this, ["TEST"], [], [action2]));

      
      var action3:Function = function(command:String):void{
	var keyword:String = command.replace("LOOK ", "");
	for each(var item:Item in items){
	    if(item.keyword == keyword){
	      write(item.longDescription);
	    }
	}
      };
      addRule(new Rule(this, ["LOOK COINS", "LOOK WRISTWATCH"], [], [action3]));



      
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
      location0.addRule(new Rule(this, ["TURN ON LIGHT"], [condition0_0], [action0_2]));

      var action0_3:Function = function():void{
        write("THE LIGHTS ARE ALREADY ON.");
      };
      location0.addRule(new Rule(this, ["TURN ON LIGHT"], [condition0_1], [action0_3]));

      var action0_4:Function = function():void{
        location0_vars.lightsOn = false;
	location0.removeExit(location0_vars.north);
	currentLocation.title = "YOUR DARK APPARTMENT";
	currentLocation.description = "THE ROOM IS PLUNGED BACK IN TO DARKNESS.";
	showLocation();
	currentLocation.description = "IT IS TOO DARK TO SEE ANYTHING";
      };
      location0.addRule(new Rule(this, ["TURN OFF LIGHT"], [condition0_1], [action0_4]));

      var action0_5:Function = function():void{
	write("THE LIGHTS ARE ALREADY OFF.");
      };
      location0.addRule(new Rule(this, ["TURN OFF LIGHT"], [condition0_0], [action0_5]));
      
      var action0_6:Function = function():void{
	write("KIPPLE IS USELESS OBJECTS, LIKE JUNK MAIL OR MATCH FOLDERS AFTER YOU USE THE LAST MATCH OR GUM WRAPPERS OR YESTERDAY'S HOMEOPAPE.  WHEN NOBODY'S AROUND, KIPPLE REPRODUCES ITSELF.  FOR INSTANCE, IF YOU GO TO BED LEAVING ANY KIPPLE AROUND YOUR APPARTMENT, WHEN YOU WAKE UP THERE IS TWICE AS MUCH OF IT.  IT ALWAYS GETS MORE AND MORE.  THERE'S THE FIRST LAW OF KIPPLE \"KIPPLE DRIVES OUT NONKIPPLE.\"");
      };
      location0.addRule(new Rule(this, ["LOOK KIPPLE"], [], [action0_6]));

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
      location0.addRule(new Rule(this, ["LOOK DOOR"], [], [action0_9]));

      



      // LOCATION 1 - WARDROBE IN YOUR APPARTMENT
      
      var location1_vars:Object = {};

      var action1_0:Function = function():void{
	write("THERE ISN'T ENOUGH SPACE TO BEND OVER, BUT YOU WOULDN'T WANT TO ANYWAY, THE ODOUR IS QUITE PUNGENT, EVEN FROM UP HERE!");
      };
      location1.addRule(new Rule(this, ["LOOK SHOE"], [], [action1_0]));

      var action1_1:Function = function():void{
	write("NO.  I'M NOT TOUCHING THEM!");
      };
      location1.addRule(new Rule(this, ["TAKE SHOE"], [], [action1_1]));

      var action1_2:Function = function():void{
	write("AMONGST THE CLOTHES ARE FEW SHIRTS, A SUIT BAG, AND A COAT.");
      };
      location1.addRule(new Rule(this, ["LOOK CLOTHES"], [], [action1_2]));

      var action1_3:Function = function():void{
	write("A FEW SHIRTS WITH QUESTIONABLE STAINS.");
      };
      location1.addRule(new Rule(this, ["LOOK SHIRT"], [], [action1_3]));

      var action1_4:Function = function():void{
	write("I THINK I'LL LEAVE THEM WHERE THEY ARE.");
      };
      location1.addRule(new Rule(this, ["TAKE SHIRT"], [], [action1_4]));

      /*
      var action1_5:Function = function():void{
	write("");
      };
      location1.addRule(new Rule(this, [""], [], []));
      */
      

      // LOCATION 2 - HALLWAY OUTSIDE YOUR APPARTMENT
      
      super(write, showLocation);
    }
  }

}
