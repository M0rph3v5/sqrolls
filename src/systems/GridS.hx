package systems;

using Imports;

class GridN extends Node<GridN>{
	public var grid:Grid;
	public var transform:Transform;
	public var gameCitizen:GameCitizen;
}

class GridS extends ListIteratingSystem<GridN>{
	var creator:EntityCreator;
	var mouseInput:MouseInput;
	var gridList:NodeList<GridN>;
	
	var lastScrollCoord:Vec2;
	
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
		
	}
	
	function onMouseUp(pos:Vec2) {
		lastScrollCoord = null;
	}
	
	function onMouseMove(pos:Vec2, mouseDown:Bool) {
		if (lastScrollCoord != null || !mouseDown) 
			return;
		
		for (node in gridList) {
			var coord = Utils.coordForPosition(pos, node.grid);
			if (coord != null) {
				creator.createScroll(node.grid, [0,1,2,3,4,5,6], coord);
				lastScrollCoord = coord;
				break;
			}
		}		
	}
	
	function add(node:GridN){
		node.grid.tiles.walk(function(current, x, y){
			var newTile = creator.createTile(node.gameCitizen.game, node.grid, new Vec2(x,y));
			//creator.createTileItem(node.grid, newTile.get(Tile), Random.randRange(0, 9), new Vec2(x,y));
			return current;
		});
	}
	
	function updateN(node:GridN, time:Float){
		calculateTotalsInGrid(node);
	}
	
	function calculateTotalsInGrid(node:GridN) {
				
		// total total
		var columnTotals = new Array();
		var rowTotals = new Array();
		var total = 0;
		node.grid.tiles.walk(function(current:Array<Entity>,x,y) {
			var currentColumnTotal = columnTotals[x];
			var currentRowTotal = rowTotals[y];			
			
			for(tile in current){
				if(!tile.has(Tile)) continue;
				var topTileItem = tile.get(Tile).stack[tile.get(Tile).stack.length-1];
				if(topTileItem == null) continue;
				total += topTileItem.get(TileItem).number;
				currentColumnTotal += topTileItem.get(TileItem).number;
				currentRowTotal += topTileItem.get(TileItem).number;
			}
			
			columnTotals[x] = currentColumnTotal;
			rowTotals[y] = currentRowTotal;
			
			return current;
		});
		node.grid.total = total;
		node.grid.columnTotals = columnTotals;
		node.grid.rowTotals = rowTotals;
		
	}
	
}
