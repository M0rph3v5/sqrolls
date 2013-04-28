package systems;

using Imports;

class GoalN extends Node<GoalN>{
	public var goal:Goal;
	public var gameCitizen:GameCitizen;
}

class GoalS extends ListIteratingSystem<GoalN>{
	public function new(){
		super(GoalN, updateN, add, remove);
	}
	
	function add(node:GoalN){
		node.gameCitizen.game.goals.push(node.entity);
	}
	
	function remove(node:GoalN){
		node.gameCitizen.game.goals.remove(node.entity);
	}
	
	function updateN(node:GoalN, time:Float){
		/*node.gameCitizen.game.grid.tiles.walk(function(current:Array<Entity>,x,y){
			for(tile in current){
				
			}
		});*/
		
		for(x in 0...node.gameCitizen.game.grid.tiles.getW()){
			for(y in 0...node.gameCitizen.game.grid.tiles.getH()){
				for(i in node.gameCitizen.game.grid.tiles.get(x,y)){
					trace("asdf");
					if(!i.has(Tile)) continue;
					if(i.get(Tile).stack.length == 0) continue;
					var tileNumber = i.get(Tile).stack[i.get(Tile).stack.length - 1].get(TileItem);
					if(tileNumber == node.goal.goal[0]){
						trace("HI");
					}
				}
			}
		}
	}
}
