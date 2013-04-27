package;

using Imports;

class EntityCreator {
	var engine:Engine;
	var graphics:Graphics;
	
	public function new(engine:Engine, graphics:Graphics){
		this.engine = engine;
		this.graphics = graphics;
	}
	
	public function createImage(){
		var image = new Image(graphics.getTexture("Character Boy"));
		
		var e = new Entity()
		.add(new Display(image, new Mat23()))
		.add(new Transform());
		
		engine.addEntity(e);
	}
	
	public function createGrid(){
		var e = new Entity()
		.add(new Grid())
		.add(new Transform());
		
		engine.addEntity(e);
	}
	
	public function createScroll(data:Array<Int>, ?beginPoint:Vec2) {
		var image = new Image(graphics.getTexture("Chest Closed"));
		
		var e = new Entity()
		.add(new Display(image, Mat23.scale(0.3, 0.3)))
		.add(new Scroll(data, beginPoint))
		.add(new Transform());
		
		engine.addEntity(e);
	}
}
