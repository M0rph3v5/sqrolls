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
		this.mouseInput.onMouseDown.add(onMouseDown);
		this.mouseInput.onMouseUp.add(onMouseUp);
	}
	
	function onMouseDown(pos:Vec2) {
		trace("down");
	}
	
	function onMouseUp(pos:Vec2) {
		trace("up");
	}
	
	function updateN(node:GridN, time:Float){
		//calculateTotalInGrid(node);
	}
	
	function calculateTotalInGrid(node:GridN) {
		var total = 0;
		node.grid.tiles.walk(function(current,x,y) {
			var topTileItem = current.stack[current.stack.length-1];
			total += topTileItem.number;
			return current;
		});
		node.grid.total = total;
	}
	
	function canStartDraggingAtPosition(pos:Vec2) { 
		
	}
	
}