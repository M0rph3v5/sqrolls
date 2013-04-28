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
		node.goal.achieved != node.goal.achieved; 
	}
}
