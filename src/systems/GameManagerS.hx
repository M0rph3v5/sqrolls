package systems;

using Imports;

class GameManagerN extends Node<GameManagerN>{
	public var game:Game;
}

class GameManagerS extends ListIteratingSystem<GameManagerN>{
	var engine:Engine;
	var creator:EntityCreator;
	
	public function new(creator:EntityCreator){
		super(GameManagerN, updateN, add, remove);
		this.creator = creator;
	}
	
	override public function addToEngine(engine:Engine){
		super.addToEngine(engine);
		this.engine = engine;
	}
	
	function add(node:GameManagerN){
		var levelgen = genLevel(node);
		
		creator.createBackgroundImage("bg", node.game);
		node.game.grid = creator.createGrid(node.game).get(Grid);		
		//creator.createScoreUI(node.game, node.game.grid);
		
		
		var inventoryEntity = creator.createInventory(node.game);
		var inventory:ScrollInventory = inventoryEntity.get(ScrollInventory);
		creator.createInventoryItem(0, node.game, inventory, [1,2,3,4], 2, false);
		creator.createInventoryItem(1, node.game, inventory, [4,3,2,1], 2, false);
		creator.createInventoryItem(2, node.game, inventory, [0,0,0,0], 1, false);
			
		// put teh static numbers on the board
		levelgen.outGrid.walk(function(current,x,y){
			if (current == 0)
				return current;
			
			// get teh tile
			var tileEntities = node.game.grid.tiles.get(x, y);
			for(tile in tileEntities){
				if(!tile.has(Tile)) continue;
				creator.createTileItem(node.game, node.game.grid, tile.get(Tile), current, new Vec2(x,y));
			}
			return current;
		});
		
		SoundManager.get_instance();
		
		creator.createMuteButton(node.game, 700, 30, new Rectangle(700,30,40,40));
	}
	
	function genLevel(node:GameManagerN){
		var levelgen : LevelGen = null;
		var bestScore : Float = -9999;
		trace(node.game.level);
		for(i in 0...20){
			var l = new LevelGen(node.game.level);
			var s : Float = l.generate();
						
			if(s > bestScore){
				levelgen = l;
				bestScore = s;
			}
		}
		
		for(i in 0...levelgen.goals.length){
			creator.createGoal(node.game, levelgen.goals[i], 450, 215 + 55 * i); // 640 on last bg
		}
		
		var x = 490;
		var y = Math.max(450, 215 + 25 + 55 * levelgen.goals.length);
		creator.createNextLevelButton(node.game, x, y, new Rectangle(x,y,180,50));
	
		return levelgen;
	}
	
	function remove(node:GameManagerN){
		
	}
	
	function updateN(node:GameManagerN, time:Float){
		var allGoalsComplete:Bool = true;
		for(goal in node.game.goals){
			if(!goal.get(Goal).achieved){
				allGoalsComplete = false;
				break;
			}
		}
		
		var cleanAchieved = false;
		if (allGoalsComplete) {
			var clean = true;
			node.game.grid.tiles.walk(function(current:Array<Entity>,x,y) {
				var itam = getTileItem(node.game.grid, x, y);
				if (itam == null)
					return current;
				
				var tileItem:TileItem = itam.get(TileItem);
				if (tileItem.number == 0) // don't count blank ones.
					return current;
				
				if (!tileItem.achieved)
					clean = false;
				return current;
			});
			
			cleanAchieved = clean;
		}
			
		if (!node.game.cleanAchieved && cleanAchieved) { // wasn't before
			SoundManager.get_instance().levelComplete();
		}
		node.game.achieved = allGoalsComplete;
		node.game.cleanAchieved = cleanAchieved;
				
		if(node.game.nextLevelButtonPressed){
			engine.removeEntity(node.entity);
			creator.createGame(node.game.level + 1);	
		}
	}
	
	// extra free funciton :D
	function getTileItem(grid:Grid, x:Int, y:Int):Entity{
		if (x < 0 || x >= grid.columns) return null;
		if (y < 0 || y >= grid.rows) return null;
		
		var current = grid.tiles.get(x,y);
		for(tile in current){
			if(!tile.has(Tile)) continue;
			return tile.get(Tile).stack[tile.get(Tile).stack.length-1];
		}
		return null;
	}
}
