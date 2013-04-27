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
		super(GridN, updateN, add);
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
			creator.createScroll([0,1,2], new Vec2(0,0));
		}

	}
	
	function onMouseUp(pos:Vec2) {
		
	}
	
	function onMouseMove(pos:Vec2) {
		
	}
	
	function add(node:GridN){
		node.grid.tiles.walk(function(current, x, y){
			var newTile = creator.createTile(node.grid, new Vec2(x,y));
			creator.createTileItem(node.grid, newTile.get(Tile), Random.randRange(0, 9), new Vec2(x,y));
			return current;
		});
	}
	
	function updateN(node:GridN, time:Float){
	
	}
	
	function calculateTotalsInGrid(node:GridN) {
				
		// total total
		var columnTotals = new Array();
		var rowTotals = new Array();
		var total = 0;
		node.grid.tiles.walk(function(current,x,y) {
			var currentColumnTotal = columnTotals[x];
			var currentRowTotal = rowTotals[y];			
			
			var topTileItem = current.stack[current.stack.length-1];			
			total += topTileItem.number;
			currentColumnTotal += topTileItem.number;
			currentRowTotal += topTileItem.number;
			
			columnTotals[x] = currentColumnTotal;
			rowTotals[y] = currentRowTotal;
			
			return current;
		});
		node.grid.total = total;
		node.grid.columnTotals = columnTotals;
		node.grid.rowTotals = rowTotals;
		
	}
	
	function isStagePositionInGrid(node:GridN, pos:Vec2) {
		var gridPosition = node.transform.position;
		var gridRectangle = new Rectangle(gridPosition.x, gridPosition.y, node.grid.width(), node.grid.height());
		return gridRectangle.containsPoint(pos.toPoint());
	}
	
	function gridPositionForStagePosition(pos:Vec2) {
		for (node in gridList) {
			calculateTotalsInGrid(node);			
			
			if (!isStagePositionInGrid(node, pos)) 
				continue;		
			return new Vec2(pos.x - node.transform.position.x, pos.y - node.transform.position.y);		 
		}
		return null;
	}
	
	
	
}
