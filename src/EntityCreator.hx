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
	
	public function createGame(){
		var e = new Entity();
		e.add(new GameState());
		
		engine.addEntity(e);		
	}
	
	public function createWorld(recordings:Array<Array<Entry>>){
		world = new Entity()
		.add(new World(recordings))
		.add(new Camera())
		.add(new WorldMap(8,6,2));
		
		engine.addEntity(world);
	}
	
	public function createTile(x:Float, y:Float, z:Float, type:TileType){
		var textureId = switch(type){
			case Grass: "Grass Block";
			case Stone: "Stone Block";
			case Dirt: "Dirt Block";
		}
		var image = new Image(graphics.getTexture(textureId));
		
		var e = new Entity()
		.add(new WorldCitizen(world))
		.add(new WorldMapCitizen(world.get(WorldMap)))
		.add(new Display(image, Mat23.translation(-50, -130)))
		.add(new Position(x, y, z))
		.add(new Transform())
		.add(new Tile(type))
		.add(new Health());
		
		engine.addEntity(e);
	}
	
	public function createPlayer(){
		var image = new Image(graphics.getTexture("Character Cat Girl"));
		
		var e = new Entity()
		.add(new WorldCitizen(world))
		.add(new WorldMapCitizen(world.get(WorldMap)))
		.add(new Display(image, Mat23.translation(-50, -140)))
		.add(new Transform())
		.add(new Motion())
		.add(new Animation())
		
		.add(new Position(4,3,0))
		.add(new CharacterAI())
		.add(new CharacterMouseControl())
		.add(new Record())
		
		.add(new EnemyTarget())
		.add(new Health());
		
		engine.addEntity(e);
		return e;
	}
	
	public function createReplayPlayer(recording:Array<Entry>){
		var image = new Image(graphics.getTexture("Character Boy"));
		
		var e = new Entity()
		.add(new WorldCitizen(world))
		.add(new WorldMapCitizen(world.get(WorldMap)))
		.add(new Display(image, Mat23.translation(-50, -140)))
		.add(new Transform())
		.add(new Motion())
		.add(new Animation())
		
		.add(new Position(4,3,0))
		.add(new CharacterAI())
		.add(new CharacterReplayControl(recording))

		.add(new EnemyTarget())
		.add(new Health());
		
		engine.addEntity(e);
		return e;
	}
	
	public function createEnemyBug(x:Float, y:Float){
		var image = new Image(graphics.getTexture("Enemy Bug"));

		var e = new Entity()
		.add(new WorldCitizen(world))
		.add(new WorldMapCitizen(world.get(WorldMap)))
		.add(new Display(image, Mat23.translation(-50, -140)))
		.add(new Transform())
		.add(new Motion())
		.add(new Flip())
		
		.add(new Position(x,y,1))
		.add(new BugAI())
		
		.add(new Health());
		
		engine.addEntity(e);
		return e;
	}
}
