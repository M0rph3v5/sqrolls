package systems;

using Imports;

class NextLevelButtonN extends Node<NextLevelButtonN>{
	public var gameCitizen:GameCitizen;
	public var button:Button;
	public var nextLevelButton:NextLevelButton;
}

class NextLevelButtonS extends ListIteratingSystem<NextLevelButtonN>{
	var graphics:Graphics;
	
	public function new(graphics:Graphics){
		super(NextLevelButtonN, updateN, add, remove);
		this.graphics = graphics;
	}
	
	function add(node:NextLevelButtonN){
		node.nextLevelButton.enabled = new Image(graphics.getTexture("button-nextlevel"));
		node.nextLevelButton.enabled.visible = false;
		node.nextLevelButton.disabled = new Image(graphics.getTexture("button-nextlevel-disabled"));
		
		node.nextLevelButton.dpo.addChild(node.nextLevelButton.enabled);
		node.nextLevelButton.dpo.addChild(node.nextLevelButton.disabled);
	}
	
	function remove(node:NextLevelButtonN){
		
	}
	
	function updateN(node:NextLevelButtonN, time:Float){
		
	}
}
