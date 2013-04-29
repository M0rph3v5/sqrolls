package systems;

using Imports;

class ButtonN extends Node<ButtonN>{
	public var gameCitizen:GameCitizen;
	public var button:Button;
	public var nextLevelButton:NextLevelButton;
}

class ButtonS extends ListIteratingSystem<ButtonN>{
	public function new(){
		super(ButtonN, updateN);
	}
	
	function updateN(node:ButtonN, time:Float){
		
	}
}
