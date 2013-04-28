package systems;

using Imports;

class GoalRenderN extends Node<GoalRenderN>{
	public var goalRender:GoalRender;
	public var gameCitizen:GameCitizen;
}

class GoalRenderS extends ListIteratingSystem<GoalRenderN>{
	var graphics:Graphics;
	
	public function new(graphics:Graphics){
		super(GoalRenderN, updateN, add, remove);
		this.graphics = graphics;
	}
	
	function add(node:GoalRenderN){
		
	}
	
	function remove(node:GoalRenderN){
		
	}
	
	function updateN(node:GoalRenderN, time:Float){
		
	}
}
