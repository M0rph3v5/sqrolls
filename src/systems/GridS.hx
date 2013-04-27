package systems;

using Imports;

class GridN extends Node<GridN>{
	public var grid:Grid;
}

class GridS extends ListIteratingSystem<GridN>{
	var creator:EntityCreator;
	var mouseInput:MouseInput;
	
	public function new(creator:EntityCreator, mouseInput:MouseInput){
		super(GridN, updateN);
		this.creator = creator;
		this.mouseInput = mouseInput;
	}
	
	function updateN(node:GridN, time:Float){
	}
	
}
