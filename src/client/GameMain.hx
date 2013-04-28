package client;

using Imports;

class GameMain {
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
		engine.addSystem(new GridCitizenS(), priority++);
		engine.addSystem(new TileCitizenS(), priority++);
		engine.addSystem(new GridS(creator, mouseInput), priority++);
		engine.addSystem(new ScrollS(creator, mouseInput), priority++);
		engine.addSystem(new GameManagerS(creator), priority++);
		
		engine.addSystem(new ScrollRenderS(graphics), priority++);
		engine.addSystem(new ScrollInventoryRenderS(graphics), priority++);
		engine.addSystem(new ScoreUIRenderS(), priority++);
		engine.addSystem(new TileItemRenderS(), priority++);
		engine.addSystem(new CoordS(), priority++);
		engine.addSystem(new RenderS(container), priority++);
		
		var g = creator.createGame();
		creator.createImage("bg");
		var ge = creator.createGrid(g.get(Game));		
		creator.createScoreUI(g.get(Game), ge.get(Grid));
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
