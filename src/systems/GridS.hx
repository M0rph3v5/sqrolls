package systems;

using Imports;

class GridN extends Node<GridN>{
	public var grid:Grid;
	public var transform:Transform;
}

class GridS extends ListIteratingSystem<GridN>{
	var creator:EntityCreator;
	var mouseInput:MouseInput;
	var gridList:NodeList<GridN>;
	
	public function new(creator:EntityCreator, mouseInput:MouseInput){
		super(GridN, updateN);
		this.creator = creator;
		this.mouseInput = mouseInput;
		this.mouseInput.onMouseDown.add(onMouseDown);
		this.mouseInput.onMouseUp.add(onMouseUp);
		this.mouseInput.onMouseMove.add(onMouseMove);
	}
	
	override public function addToEngine(engine:Engine){
		super.addToEngine(engine);
		this.gridList = engine.getNodeList(GridN);
	}
	
	function onMouseDown(pos:Vec2) {
		
		var gridPos = gridPositionForStagePosition(pos);
		if (gridPos != null) {
			trace("in teh grid pos" + gridPos);
		}

	}
	
	function onMouseUp(pos:Vec2) {
		
	}
	
	function onMouseMove(pos:Vec2) {
		
	}
	
	function updateN(node:GridN, time:Float){
		
	}
	
	function calculateTotalsInGrid(node:GridN) {
		// columns / row totals
		node.grid.tiles.walk(function(current,x,y) {			
			return current;
		});
				
		// total total
		var total = 0;
		node.grid.tiles.walk(function(current,x,y) {
			var topTileItem = current.stack[current.stack.length-1];
			total += topTileItem.number;
			return current;
		});
		node.grid.total = total;
	}
	
	function isStagePositionInGrid(node:GridN, pos:Vec2) {
		var gridPosition = node.transform.position;
		var gridRectangle = new Rectangle(gridPosition.x, gridPosition.y, node.grid.width(), node.grid.height());
		return gridRectangle.containsPoint(pos.toPoint());
	}
	
	function gridPositionForStagePosition(pos:Vec2) {
		for (node in gridList) {
			if (!isStagePositionInGrid(node, pos)) 
				continue;		
			return new Vec2(pos.x - node.transform.position.x, pos.y - node.transform.position.y);		 
		}
		return null;
	}
	
	
	
}