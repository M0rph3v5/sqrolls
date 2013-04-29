package;

using Imports;

class EntityCreator {
	var engine:Engine;
	var graphics:Graphics;
	
	public function new(engine:Engine, graphics:Graphics){
		this.engine = engine;
		this.graphics = graphics;
	}
	
	public function createBackgroundImage(textureId:String, game:Game){
		var image = new Image(graphics.getTexture(textureId));
		
		var e = new Entity()
		.add(new GameCitizen(game))
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
		
	public function createInventory(game:Game) {
		var dpo = new Sprite();
		
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new ScrollInventory())
		.add(new ScrollInventoryRender(dpo))
		
		.add(new Transform())
		.add(new Display(dpo, new Mat23(), 9));
				
		engine.addEntity(e);
		return e;
	}
	
	public function createInventoryItem(index:Int, game:Game, inventory:ScrollInventory, data:Array<Int>, count:Int, mouseSlave:Bool, ?pos:Vec2) {
		if (pos == null)
			pos = new Vec2(0,0);
		
		var dpo = new Sprite();
		var transform = new Transform();
		transform.position = pos;		
		
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new ScrollInventoryCitizen(inventory, index))
		.add(new ScrollInventoryItem(data, count, mouseSlave))
		.add(new ScrollInventoryItemRender(dpo))
		
		.add(transform)
		.add(new Display(dpo, new Mat23(), 9));
		
		engine.addEntity(e);
		return e;
	}
	
	public function createGoal(game:Game, goal:Array<Int>, x:Float, y:Float){
		var dpo = new Sprite();
		
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new Goal(goal))
		.add(new GoalRender(dpo))
		
		.add(new Transform())
		.add(new Display(dpo, Mat23.translation(x,y), 5));
		
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
	
	public function createNextLevelButton(game:Game, x:Float, y:Float, rect:Rectangle){
		var dpo = new Sprite();
		
		var e = new Entity()
		.add(new GameCitizen(game))
		.add(new NextLevelButton(dpo))
		.add(new Button(rect))
		
		.add(new Transform())
		.add(new Display(dpo, Mat23.translation(x,y), 1));
		
		engine.addEntity(e);
	}
}
