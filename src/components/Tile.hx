package components;

using Imports;

class Tile {
	public var onTileItemAdded:Signal2<Tile, TileItem>; 
	
	public var stack : Array<TileItem>;
	
	public function new(){
		stack = new Array<TileItem>();
		onTileItemAdded = new Signal2();
	}
}
