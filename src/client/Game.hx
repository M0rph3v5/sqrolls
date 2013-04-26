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
		engine.addSystem(new GameManager(creator), priority++);
		engine.addSystem(new WorldS(keyboardInput, creator), priority++);
		
		engine.addSystem(new CharacterMouseControlS(mouseInput), priority++);
		engine.addSystem(new CharacterReplayControlS(), priority++);
		engine.addSystem(new CharacterAIRecordS(), priority++);
		engine.addSystem(new CharacterAIS(creator), priority++);
		
		engine.addSystem(new BugAIS(), priority++);
		engine.addSystem(new HealthS(), priority++);
		
		engine.addSystem(new MotionS(), priority++);
		engine.addSystem(new PositionS(), priority++);
		engine.addSystem(new WorldMapS(creator), priority++);
		
		engine.addSystem(new AnimationS(), priority++);
		engine.addSystem(new FlipS(), priority++);
		engine.addSystem(new RenderS(container), priority++);
		
		creator.createGame();
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
