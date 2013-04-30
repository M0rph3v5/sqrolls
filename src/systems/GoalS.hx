package systems;

using Imports;

class GoalN extends Node<GoalN>{
	public var goal:Goal;
	public var gameCitizen:GameCitizen;
}

class GoalS extends ListIteratingSystem<GoalN>{
	var goalNodeList:NodeList<GoalN>;
	
	public function new(){
		super(GoalN, updateN, add, remove);
	}	
				
	override public function addToEngine(engine:Engine){
		super.addToEngine(engine);
		goalNodeList = engine.getNodeList(GoalN);		
	}
	
	override public function update(time:Float) {
		super.update(time);

	}
	
	function add(node:GoalN){
		node.gameCitizen.game.goals.push(node.entity);
	}
	
	function remove(node:GoalN){
		node.gameCitizen.game.goals.remove(node.entity);
	}
	
	function updateN(node:GoalN, time:Float){
		var achieved:Bool = false;

		var achievedArray = new Array2(node.gameCitizen.game.grid.columns,node.gameCitizen.game.grid.rows);
		achievedArray.fill(0);
		
		node.gameCitizen.game.grid.tiles.walk(function(current:Array<Entity>,x,y){
			
			var directions = [[1,0],[0,1]];
			for (direction in directions) {
				if (achievedArray.get(x,y) == 1)
					continue;
				
				var tileAchieved = false;
				var dx = direction[0];
				var dy = direction[1];
				
				tileAchieved = checkRay(node.gameCitizen.game.grid, node.goal.goal, x, y, dx, dy);
				achievedArray.set(x,y,tileAchieved?1:0);
				
				if (tileAchieved) { // mark the remaining of the achieved goal true
					achieved = tileAchieved;
					
					var tx = x;
					var ty = y;
					for (i in 0...node.goal.goal.length-1) {				
						tx += dx;
						ty += dy;
						achievedArray.set(tx,ty,tileAchieved?1:0);						
					}					
				}
				
			}
			return current;
		});
		
		//trace(achievedArray);
		
		achievedArray.walk(function(current,x,y){			
			var tileItemEntity = getTileItem(node.gameCitizen.game.grid, x, y);
			if (tileItemEntity != null) {
				var item:TileItem = tileItemEntity.get(TileItem);
				if (current == 1) {
					if(Lambda.has(item.goals, node.entity))
						return current;
					item.goals.push(node.entity);
					item.achieved = true;
				} else {
					if(!Lambda.has(item.goals, node.entity))
						return current;
					item.goals.remove(node.entity);
					if (item.goals.length == 0) // if i was the last goal to posses this one, allow to set false
						item.achieved = false;
				}
			}
			return current;
		});
		
		if (!node.goal.achieved && achieved) {
			SoundManager.get_instance().goalComplete();
		}
		
		node.goal.achieved = achieved;
	}
	
	function checkRay(grid:Grid, goal:Array<Int>, startX:Int, startY:Int, dirX:Int, dirY:Int):Bool{
		for(i in 0...goal.length){
			if(startX < 0 || startX > 4) return false;
			if(startY < 0 || startY > 4) return false;
			
			var topTileItem = getTileItem(grid, startX, startY);
			if(topTileItem == null) return false;
			
			if(topTileItem.get(TileItem).number != goal[i]) return false; 
			
			startX += dirX;
			startY += dirY;
		}
		
		return true;
	}
	
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
