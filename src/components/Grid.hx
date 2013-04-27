package components;

using Imports;

class Grid {
	public var tiles:Array2<Array<Entity>>;
	public var columns:Int = 6;	 
	public var rows:Int = 6;
	public var tileSize:Int = 85;
	
	public var total:Int;
	public var columnTotals:Array<Int>;
	public var rowTotals:Array<Int>;
		
	public function new(){
		tiles = new Array2(columns,rows);
		tiles.walk(function(current, x, y){
			return new Array();
		});
		
		columnTotals = new Array();
		rowTotals = new Array();
	}
	
	public function width():Int {
		return tileSize * columns;
	}
	
	public function height():Int {
		return tileSize * rows;
	}
}
