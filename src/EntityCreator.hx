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
	
	public function createGame(){
		var e = new Entity()
		.add(new Game());
		
		engine.addEntity(e);
		
		return e;
	}
		
	public function createGrid(game:Game){
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new Grid())
		.add(new Transform());
		
		engine.addEntity(e);
		return e;
	}
	
	public function createTile(game:Game,grid:Grid, pos:Vec2){
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new GridCitizen(grid, pos))
		.add(new Tile());
		
		engine.addEntity(e);
		return e;
	}
	
	public function createTileItem(game:Game,grid:Grid, tile:Tile, number:Int, pos:Vec2){
		var dpo = new Sprite();
				
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new TileCitizen(tile))
		.add(new GridCitizen(grid, pos))
		.add(new TileItem(number))
		.add(new TileItemRender(dpo))
		
		.add(new Transform())
		.add(new Display(dpo, new Mat23()));
		
		engine.addEntity(e);
		return e;
	}
	
	public function createScroll(game:Game, grid:Grid, data:Array<Int>, ?beginPoint:Vec2) {
		var dpo = new Sprite();
		
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new Coord(beginPoint))
		.add(new Scroll(grid, data, beginPoint))
		.add(new ScrollRender(dpo))
		.add(new Transform())
		.add(new Display(dpo, new Mat23()));
		
		engine.addEntity(e);
		return e;
	}
	
	public function createScoreUI(game:Game, grid:Grid){
		var dpo = new Sprite();
		
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new ScoreUIRender(dpo, grid))
		
		.add(new Transform())
		.add(new Display(dpo, Mat23.translation(575, 675)));
		
		engine.addEntity(e);
	}
}
