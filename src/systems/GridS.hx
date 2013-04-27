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
		calculateTotalInGrid(node);
	}
	
	function calculateTotalInGrid(node:GridN) {
		var total = 0;
		node.grid.tiles.walk(function(current:Array<Entity>,x,y) {
			for(e in current){
				if(!e.has(Tile)) continue;
				var topTileItem = e.get(Tile).stack[e.get(Tile).stack.length-1];
				total += topTileItem.number;
			}
			return current;
		});
		node.grid.total = total;
		trace("total " + total);
	}
	
}
