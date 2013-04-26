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
}
