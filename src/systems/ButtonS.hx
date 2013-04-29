package systems;

using Imports;

class ButtonN extends Node<ButtonN>{
	public var button:Button;
}

class ButtonS extends ListIteratingSystem<ButtonN>{
	public function new(){
		super(ButtonN, updateN);
	}
	
	function updateN(node:ButtonN, time:Float){
		
	}
}
