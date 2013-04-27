package components;

using Imports;

class Tile {
	public var onTileItemAdded:Signal2<Tile, TileItem>; 
	
	public var stack : Array<TileItem>;
	
	public function new(){
		stack = new Array<TileItem>();
		onTileItemAdded = new Signal2();
	}
	
	public function push(tileItem:TileItem){
		stack.push(tileItem);
		onTileItemAdded.dispatch(this, tileItem);
	}
}
