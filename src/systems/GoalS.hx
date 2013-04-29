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
		var achieved:Bool = false;

		node.gameCitizen.game.grid.tiles.walk(function(current:Array<Entity>,x,y){
			achieved = achieved || checkRay(node.gameCitizen.game.grid, node.goal.goal, x, y, 1, 0);
			//achieved = achieved || checkRay(node.gameCitizen.game.grid, node.goal.goal, x, y, -1, 0);
			//achieved = achieved || checkRay(node.gameCitizen.game.grid, node.goal.goal, x, y, 0, -1);
			//achieved = achieved || checkRay(node.gameCitizen.game.grid, node.goal.goal, x, y, 0, 1);
			
			return current;
		});
		
		node.goal.achieved = achieved;
	}
	
	function checkRay(grid:Grid, goal:Array<Int>, startX:Int, startY:Int, dirX:Int, dirY:Int):Bool{
		for(i in 0...goal.length){
			if(startX < 0 || startX > 5) return false;
			if(startY < 0 || startY > 5) return false;
			
			var topTileItem = getTileItem(grid, startX, startY);
			if(topTileItem == null) return false;
			
			if(topTileItem.get(TileItem).number != goal[i]) return false; 
			
			startX += dirX;
			startY += dirY;
		}
		
		return true;
	}
	
	function getTileItem(grid:Grid, x:Int, y:Int):Entity{
		var current = grid.tiles.get(x,y);
		for(tile in current){
			if(!tile.has(Tile)) continue;
			return tile.get(Tile).stack[tile.get(Tile).stack.length-1];
		}
		return null;
	}
}
