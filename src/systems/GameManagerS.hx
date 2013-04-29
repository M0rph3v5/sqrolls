package systems;

using Imports;

class GameManagerN extends Node<GameManagerN>{
	public var game:Game;
}

class GameManagerS extends ListIteratingSystem<GameManagerN>{
	var creator:EntityCreator;
	
	public function new(creator:EntityCreator){
		super(GameManagerN, updateN, add, remove);
		this.creator = creator;
	}
	
	function add(node:GameManagerN){
		var levelgen = genLevel(node);
		
		creator.createImage("bg");
		node.game.grid = creator.createGrid(node.game).get(Grid);		
		//creator.createScoreUI(node.game, node.game.grid);
		
		var inventoryEntity = creator.createInventory(node.game);
		var inventory:ScrollInventory = inventoryEntity.get(ScrollInventory);
		creator.createInventoryItem(0, node.game, inventory, [1,2,3,4,5], 4, false);
		creator.createInventoryItem(1, node.game, inventory, [5,4,3,2,1], 4, false);
		creator.createInventoryItem(2, node.game, inventory, [0,0,0,0,0], 1, false);
			
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
	}
	
	function genLevel(node:GameManagerN){
		var levelgen : LevelGen = null;
		var bestScore : Float = -9999;
		for(i in 0...20){
			var l = new LevelGen();
			var s : Float = l.generate();
						
			if(s > bestScore){
				levelgen = l;
				bestScore = s;
			}
		}
		
		for(i in 0...levelgen.goals.length){
			creator.createGoal(node.game, levelgen.goals[i], 450, 215 + 55 * i); // 640 on last bg
		}
	
		return levelgen;
	}
	
	function remove(node:GameManagerN){
		
	}
	
	function updateN(node:GameManagerN, time:Float){
		
	}
}
