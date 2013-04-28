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
		
		creator.createImage("bg");
		node.game.grid = creator.createGrid(node.game).get(Grid);		
		creator.createScoreUI(node.game, node.game.grid);
		
		var inventoryEntity = creator.createInventory(node.game);
		var inventory:ScrollInventory = inventoryEntity.get(ScrollInventory);
		creator.createInventoryItem(0, node.game, inventory, [1,2,3,4,5,0], 2, false);
		creator.createInventoryItem(1, node.game, inventory, [5,4,3,2,1,0], 2, false);
		creator.createInventoryItem(2, node.game, inventory, [0,0,0,0,0,0], 1, false);
	}
	
	function genLevel(node:GameManagerN){
		var levelgen = new LevelGen(6,6);
		levelgen.generate();
	
		for(i in 0...levelgen.goals.length){
			creator.createGoal(node.game, levelgen.goals[i], 700, 200 + 50 * i);
		}
	}
	
	function remove(node:GameManagerN){
		
	}
	
	function updateN(node:GameManagerN, time:Float){
		
	}
}
