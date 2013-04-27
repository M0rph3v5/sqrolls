package;

using Imports;

class EntityCreator {
	var engine:Engine;
	var graphics:Graphics;
	
	public function new(engine:Engine, graphics:Graphics){
		this.engine = engine;
		this.graphics = graphics;
	}
	
	public function createImage(textureId:String){
		var image = new Image(graphics.getTexture(textureId));
		
		var e = new Entity()
		.add(new Display(image, new Mat23()))
		.add(new Transform());
		
		engine.addEntity(e);
		return e;
	}
	
	public function createGrid(){
		var e = new Entity()
		.add(new Grid())
		.add(new Transform());
		
		engine.addEntity(e);
		return e;
	}
	
	public function createTile(grid:Grid, pos:Vec2){
		var e = new Entity()
		.add(new GridCitizen(grid, pos))
		.add(new Tile());
		
		engine.addEntity(e);
		return e;
	}
	
	public function createTileItem(grid:Grid, tile:Tile, number:Int, pos:Vec2){
		var dpo = new Sprite();
				
		var e = new Entity()
		.add(new TileCitizen(tile))
		.add(new GridCitizen(grid, pos))
		.add(new TileItem(number))
		.add(new TileItemRender(dpo))
		
		.add(new Transform())
		.add(new Display(dpo, new Mat23()));
		
		engine.addEntity(e);
		return e;
	}
	
	public function createScroll(data:Array<Int>, ?beginPoint:Vec2) {
		var image = new Image(graphics.getTexture("Chest Closed"));
		
		var e = new Entity()
		.add(new Display(image, Mat23.scale(0.3, 0.3)))
		.add(new Coord())
		.add(new Scroll(data, beginPoint))
		.add(new Transform());
		
		engine.addEntity(e);
	}
}
