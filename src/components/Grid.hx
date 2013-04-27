package components;

using Imports;

class Grid {
	public var tiles:Array2<Tile>;
	public var total:Int;
	
	public function new(){
		tiles = new Array2(6,6);
	}
}
