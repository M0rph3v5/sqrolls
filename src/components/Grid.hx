package components;

using Imports;

class Grid {
	public var tiles:Array2<Array<Entity>>;
	public var total:Int;
	
	public function new(){
		tiles = new Array2(6,6);
		tiles.walk(function(current, x, y){
			return new Array();
		});
	}
}
