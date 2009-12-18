package ch.forea.textas{

  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.KeyboardEvent;
  import flash.utils.Dictionary;
  import __AS3__.vec.Vector;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;

  public class Main extends Sprite{
    
    private var outputText:TextField;
    private var world:World;
    private var inputString:String = "";
    private var inputText:TextField;

    [Embed(source="/Users/jonathanmcallister/Documents/workspace/textas/font/C64.TTF", fontName="Commodore 64", advancedAntiAliasing="false", unicodeRange="U+0041-005A,U+0020,U+0030-0039")]
    public var font:String;

    public function Main(){
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.align = StageAlign.TOP_LEFT;

      world = new World(write);
      
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
      graphics.beginFill(0x4242E7);
      graphics.drawRect(40, 48, 645, 400);
      graphics.endFill();
      
      outputText = new TextField();
      //label.autoSize = TextFieldAutoSize.LEFT;

      var format:TextFormat = new TextFormat();
      format.font = "Commodore 64";
      format.color = 0xA5A5FF;
      format.size = 20;

      outputText.sharpness = 400;
      outputText.thickness = -200;
      outputText.antiAliasType = flash.text.AntiAliasType.ADVANCED;

      outputText.defaultTextFormat = format;
      outputText.x = 40;
      outputText.y = 48;
      outputText.width = 645;
      outputText.height = 380;
      outputText.wordWrap = true;
      addChild(outputText);
      
      inputText = new TextField();
      inputText.defaultTextFormat = format;
      inputText.x = 40;
      inputText.y = 428;
      inputText.width = 640;
      inputText.height = 20;
      addChild(inputText);
      
      showLocation();
    }

    private function keyDown(e:KeyboardEvent):void{
      if((e.keyCode >= 65 && e.keyCode <= 90) || e.keyCode == 32 || (e.keyCode >= 48 && e.keyCode <= 57)){
	if(inputString.length < 38) inputString += String.fromCharCode(e.keyCode).toUpperCase();
      }else if(e.keyCode == 8 || e.keyCode == 46){
	inputString = inputString.slice(0, inputString.length - 1);
      }else if(e.keyCode == 13){
	action();
      }
      inputText.text = inputString;
    }

    private function write(input:String):void{
      outputText.appendText("\n" + input);
      outputText.scrollV = outputText.maxScrollV;
    }

    private function showLocation():void{
      outputText.text = "";
      write("----------------------------------------");
      write(world.currentLocation.title);
      write("\n");
      write(world.currentLocation.description);
      write("\n");
      write("Available exits: " + world.currentLocation.exits.join(", "));
      write("----------------------------------------");
      write("\n");
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
	  //trace("direction found:", words[i]);
	  if(world.testDirection(words[i])){
	    inputString = "";
	    showLocation();
	  }else{
	    write("You can't go that way.");
	    inputString = "";
	  }
	  return;
	}else if(!foundVerb && world.verbs.indexOf(words[i]) > -1){
	  //trace("verb found:", words[i]);
	  foundWords = words[i];
	  foundVerb = true;
	}else if(foundVerb && foundNouns < 2 && world.nouns.indexOf(words[i]) > -1){
	  //trace("noun found:", words[i]);
	  foundWords += " " + words[i];
	  foundNouns++;
	}
      }

      if(!foundVerb){
	write("I do not understand what you want to do.");
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

      write("I do not understand what you want to do.");
      inputString = "";
      
    }

  }

}
