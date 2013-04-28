package systems;

using Imports;

class GoalRenderN extends Node<GoalRenderN>{
	public var goal:Goal;
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
		var tf:TextField = new TextField(85,85,node.goal.goal.toString());
		tf.hAlign = starling.utils.HAlign.LEFT;
		tf.fontSize = 30;
		node.goalRender.dpo.addChild(tf);
	}
	
	function remove(node:GoalRenderN){
		
	}
	
	function updateN(node:GoalRenderN, time:Float){
		
	}
}
