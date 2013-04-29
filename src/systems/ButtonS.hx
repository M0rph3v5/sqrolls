package systems;

using Imports;

class ButtonN extends Node<ButtonN>{
	public var gameCitizen:GameCitizen;
	public var button:Button;
	public var nextLevelButton:NextLevelButton;
}

class ButtonS extends ListIteratingSystem<ButtonN>{
	var mouseInput:MouseInput;
	
	public function new(mouseInput:MouseInput){
		super(ButtonN, updateN);
		this.mouseInput = mouseInput;
	}
	
	function updateN(node:ButtonN, time:Float){
		
	}
}
