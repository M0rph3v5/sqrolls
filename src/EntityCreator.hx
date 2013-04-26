package;

using Imports;

class EntityCreator {
	var engine:Engine;
	var graphics:Graphics;
	var world:Entity;
	
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
}
