package systems;

using Imports;

class ScoreUIRenderN extends Node<ScoreUIRenderN>{
	public var scoreUIRender:ScoreUIRender;
}

class ScoreUIRenderS extends ListIteratingSystem<ScoreUIRenderN>{
	public function new(){
		super(ScoreUIRenderN, updateN, add, remove);
	}
	
	public function add(node:ScoreUIRenderN){
		trace("!!!!!");
		node.scoreUIRender.tf = new TextField(50,50,node.scoreUIRender.grid.total + "sdfkjasldfjasldfj");
		node.scoreUIRender.tf.color = 0xffffff;
		node.scoreUIRender.displayObjectContainer.addChild(node.scoreUIRender.tf);
	}
	
	public function remove(node:ScoreUIRenderN){
		node.scoreUIRender.displayObjectContainer.removeChild(node.scoreUIRender.tf);
	}
	
	public function updateN(node:ScoreUIRenderN, time:Float){
		node.scoreUIRender.tf.text = node.scoreUIRender.grid.total + "";
	}
}