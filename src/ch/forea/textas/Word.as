package ch.forea.textas{

  public class Word{
    
    public static const DIRECTION:uint = 0;
    public static const VERB:uint = 1;
    public static const NOUN:uint = 2;

    public var _keyword:String;
    public var _alternatives:Array = [];
    public var _type:uint;

    public function Word(keyword:String, type:uint = 2, alternatives:Array = null){
      _keyword = keyword;
      _type = type;
      _alternatives = alternatives;
    }

    public function get keyword():String{
      return _keyword;
    }

    public function get alternatives():Array{
      return _alternatives ? _alternatives.concat() : [];
    }

    public function get type():uint{
      return _type;
    }

  }

}

