package ch.forea.textas{

  public class AbstractWorld{

    public var version:String = "0.0.0.0005";

    public var currentLocation:Location;

    public var inventory:Location;
    
    private var _items:Vector.<Item>;
    
    public function checkForItem(itemName:String):Boolean{
      for each(var item:Item in _items){
	if(item.keyword == itemName){
          return true;
	}
      }
      return false;
    }

    private var _directions:Vector.<String> = new Vector.<String>();
    private var _verbs:Vector.<String> = new Vector.<String>();
    private var _nouns:Vector.<String> = new Vector.<String>();
    private var _words:Vector.<Word>;
    private var _rules:Vector.<Rule>;

    protected var write:Function;
    protected var showLocation:Function;

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

    public function get items():Vector.<Item>{
      return _items.concat();
    }

    public function addRule(rule:Rule):void{
      if(!_rules) _rules = new Vector.<Rule>();
      _rules.push(rule);
    }
    public function removeRule(rule:Rule):void{
      if(_rules.indexOf(rule) > -1){
        _rules.splice(_rules.indexOf(rule), 1);
      }
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

    public function set words(words:Vector.<Word>):void{
      _words = words;
    }

    public function set items(items:Vector.<Item>):void{
      _items = items;
    }

    public function testWord(testWord:String):String{
      for each(var i:Word in _words){
	  if(testWord == i.keyword) return i.keyword;
	  for each(var j:String in i.alternatives){
	      if(testWord == j) return i.keyword;
	  }
      }
      return null;
    }


    public function AbstractWorld(write:Function, showLocation:Function){
      this.write = write;
      this.showLocation = showLocation;
      
      for each(var word:Word in _words){
          if(word.type == Word.DIRECTION){
            _directions.push(word.keyword);
          }else if(word.type == Word.VERB){
            _verbs.push(word.keyword);
          }else{
            _nouns.push(word.keyword);
          }
      }
    }

    

  }

}


