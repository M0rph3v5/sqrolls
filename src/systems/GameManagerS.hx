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
		genLevel(node);
		var inventoryEntity = creator.createInventory(node.game);
		var inventory:ScrollInventory = inventoryEntity.get(ScrollInventory);
		creator.createInventoryItem(node.game, inventory, [1,2,3,4,5,0], 2, false);
		creator.createInventoryItem(node.game, inventory, [5,4,3,2,1,0], 2, false);
		creator.createInventoryItem(node.game, inventory, [0,0,0,0,0,0], 1, false);
	}
	
	function genLevel(node:GameManagerN){
/*		node.grid.tiles.walk(function(current, x, y){
			for(e in current){
				if(!e.has(Tile)) continue;
				creator.createTileItem(node.gameCitizen.game, node.grid, e.get(Tile), Random.randRange(0, 9), new Vec2(x,y));
			}
			return current;
		});
		 * 
		 */
		
		var levelgen = new LevelGen(6,6);
		levelgen.generate();
		
	}
	
	function remove(node:GameManagerN){
		
	}
	
	function updateN(node:GameManagerN, time:Float){
		
	}
}
