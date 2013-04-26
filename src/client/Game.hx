package client;

using Imports;

class Game {
	var container:DisplayObjectContainer;
	var engine:Engine;
	var graphics:Graphics;
	var mouseInput:MouseInput;
	var keyboardInput:KeyboardInput;
	var creator:EntityCreator;
	
	public function new(container:DisplayObjectContainer, width:Float, height:Float){
		this.container = container;
		prepare();
		start();
	}
	
	function prepare(){
		engine = new Engine();
		graphics = new Graphics();
		mouseInput = new MouseInput(Starling.current.nativeStage);
		keyboardInput = new KeyboardInput(Starling.current.nativeStage);
		creator = new EntityCreator(engine, graphics);
		
		var priority:Int = 0;
		engine.addSystem(new RenderS(container), priority++);
	}
	
	function start(){
		var t = new StarlingTickProvider();
		Starling.juggler.add(t);
		t.onTick.add(function(time:Float){
			engine.update(time);
		});
	}
}

private class StarlingTickProvider implements IAnimatable{
	public var onTick:Signal1<Float>;
	
	public function new(){
		onTick = new Signal1<Float>();
	}
	
	public function advanceTime(time:Float){
		onTick.dispatch(time);
	}
}
