package ch.forea.textas{

  public class Exit{

    public static const UNDEFINED:uint = 0;
    public static const NORTH:uint = 1;
    public static const SOUTH:uint = 2;
    public static const EAST:uint = 3;
    public static const WEST:uint = 4;
    public static const UP:uint = 5;
    public static const DOWN:uint = 6;
    public static const NORTHEAST:uint = 7;
    public static const NORTHWEST:uint = 8;
    public static const SOUTHEAST:uint = 9;
    public static const SOUTHWEST:uint = 10;
    public static const IN:uint = 11;
    public static const OUT:uint = 12;

    public static const directionNames:Array = ["UNDEFINED", "NORTH", "SOUTH", "EAST", "WEST", "UP", "DOWN", "NORTHEAST", "NORTHWEST", "SOUTHEAST", "SOUTHWEST", "IN", "OUT"];
    public static const shortDirectionNames:Array = ["NULL", "N", "S", "E", "W", "U", "D", "NE", "NW", "SE", "SW", "I", "O"];
    
    private var _leadsTo:Location;
    private var _direction:uint;

    private var _directionName:String;
    private var _shortDirectionName:String;

    public function Exit(direction:uint = 0, leadsTo:Location = null){
      _direction = direction;
      _leadsTo = leadsTo;

      if(direction <= directionNames.length){
	_directionName = directionNames[direction];
      }
      if(direction <= shortDirectionNames.length){
	_shortDirectionName = shortDirectionNames[direction];
      }
    }

    public function toString():String{
      return _directionName;
    }

    public function set directionName(directionName:String):void{
      _directionName = directionName;
    }

    public function get directionName():String{
      return _directionName;
    }

    public function set shortDirectionName(shortDirectionName:String):void{
      _shortDirectionName = shortDirectionName;
    }

    public function get shortDirectionName():String{
      return _shortDirectionName;
    }

    public function set leadsTo(leadsTo:Location):void{
      _leadsTo = leadsTo;
    }

    public function get leadsTo():Location{
      return _leadsTo;
    }

  }

}
