package components;

using Imports;

class Grid {
	public var columns:Int = 6;	 
	public var rows:Int = 6;
	public var tileSize:Int = 50;
	
	public var tiles:Array2<Tile>;	
	public var total:Int;
	public var columnTotals:Array<Int>;
	public var rowTotals:Array<Int>;
		
	public function new(){
		tiles = new Array2(columns,rows);
		tiles.walk(function(current,x,y){
			return new Tile(new Vec2(x,y));
		});
		
		tiles.walk(function(current,x,y){
			current.push(new TileItem(Random.randRange(0,9)));
			return current;
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
