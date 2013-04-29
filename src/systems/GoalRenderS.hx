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
			
		var x = 0.0;
		var y = 15;
		var goalBackgroundImage = new Image(graphics.getTexture("goal-item-bg"));
		node.goalRender.dpo.addChild(goalBackgroundImage);
		goalBackgroundImage.x = x;
		goalBackgroundImage.y = y;
		
		node.goalRender.correctImage = new Image(graphics.getTexture("checkmark"));
		node.goalRender.dpo.addChild(node.goalRender.correctImage);
		node.goalRender.correctImage.x = x;
		node.goalRender.correctImage.y = y;
		
		x += 40;
		
		for (number in node.goal.goal) {
			var image = new Image(graphics.getTextureSymbolForNumber(number));			
			node.goalRender.symbolImages.push(image);
			node.goalRender.dpo.addChild(image);
			
			image.x = x;
			x += image.width + 5;
		}
		
		
		/*var tf:TextField = node.goalRender.tf = new TextField(200,40,"");
		tf.hAlign = starling.utils.HAlign.LEFT;
		tf.fontSize = 30;
		node.goalRender.dpo.addChild(tf);*/
	}
	
	function remove(node:GoalRenderN){
		
	}
	
	function updateN(node:GoalRenderN, time:Float){
		node.goalRender.correctImage.visible = node.goal.achieved;
		//var achievedText:String = node.goal.achieved ? "X" : " ";
		//node.goalRender.tf.text = '[$achievedText] ${node.goal.goal.toString()}'; 
	}
}
