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
		var released = !mouseInput.mouseDown && node.button.wasDown;
		
		node.button.down = false;
		node.button.mouseOver = false;
		node.button.pressed = false;
		
		if(mouseInput.lastMousePos != null && node.button.area.contains(mouseInput.lastMousePos.x, mouseInput.lastMousePos.y)) {	
			node.button.down = true;
			node.button.pressed = mouseInput.mouseDown;
			if(released){
				node.button.pressed = true;
			}
		}
		
		node.button.wasDown = mouseInput.mouseDown;
	}
}
