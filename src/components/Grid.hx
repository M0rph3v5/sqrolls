package components;

using Imports;

class Grid {
	public var tiles:Array2<Tile>;
	public var total:Int;
	
	public function new(){
		tiles = new Array2(6,6);
		tiles.walk(function(current,x,y){
			return new Tile(new Vec2(x,y));
		});
		
		tiles.walk(function(current,x,y){
			current.push(new TileItem(Random.randRange(0,9)));
			return current;
		});
	}
}
