package systems;

using Imports;

class LevelRenderN extends Node<LevelRenderN>{
	public var gameCitizen:GameCitizen;
	public var levelRender:LevelRender;
}

class LevelRenderS extends ListIteratingSystem<LevelRenderN>{
	public function new(){
		super(LevelRenderN, updateN, add);
	}
	
	function add(node:LevelRenderN){
		node.levelRender.tf.color = 0xffffff;
		//node.levelRender.tf.fontSize = 13;
		node.levelRender.tf.fontName = "Courgette Regular";
	}
	
	function updateN(node:LevelRenderN, time:Float){
		node.levelRender.tf.text = "Puzzle: " + (node.gameCitizen.game.level + 1);
	}
}
