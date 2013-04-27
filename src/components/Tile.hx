package components;

using Imports;

class Tile {
	public var onChanged:Signal1<Tile>;
	public var onTileItemAdded:Signal2<Tile, TileItem>; 
	
	public var pos:Vec2;
	public var stack : Array<TileItem>;
	
	public function new(pos:Vec2){
		this.pos = pos;
		stack = new Array<TileItem>();
		onChanged = new Signal1();
		onTileItemAdded = new Signal2();
	}
	
	public function push(tileItem:TileItem){
		stack.push(tileItem);
		onChanged.dispatch(this);
		onTileItemAdded.dispatch(this, tileItem);
	}
}