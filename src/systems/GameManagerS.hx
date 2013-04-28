package systems;

using Imports;

class GameManagerN extends Node<GameManagerN>{
	public var grid:Grid;
	public var gameCitizen:GameCitizen;
}

class GameManagerS extends ListIteratingSystem<GameManagerN>{
	var creator:EntityCreator;
	
	public function new(creator:EntityCreator){
		super(GameManagerN, updateN, add, remove);
		this.creator = creator;
	}
	
	function add(node:GameManagerN){
		genLevel(node);
	}
	
	function genLevel(node:GameManagerN){
		node.grid.tiles.walk(function(current, x, y){
			for(e in current){
				if(!e.has(Tile)) continue;
				creator.createTileItem(node.gameCitizen.game, node.grid, e.get(Tile), Random.randRange(0, 9), new Vec2(x,y));
			}
			return current;
		});
		
		new LevelGen(6,6);
	}
	
	function remove(node:GameManagerN){
		
	}
	
	function updateN(node:GameManagerN, time:Float){
		
	}
}
