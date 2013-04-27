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
		.add(new Grid());
		
		engine.addEntity(e);
	}
	
	public function createTile(grid:Grid, pos:Vec2){
		var e = new Entity()
		.add(new GridCitizen(grid, pos))
		.add(new Tile());
		
		engine.addEntity(e);
	}
	
	public function createTileItem(tile:Tile, number:Int){
		var e = new Entity()
		.add(new TileCitizen(tile))
		.add(new TileItem(number));
		
		engine.addEntity(e);
	}
}
