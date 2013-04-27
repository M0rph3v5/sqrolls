package systems;

using Imports;

class GridRenderN extends Node<GridRenderN>{
	public var grid:Grid;
}

class GridRenderS extends ListIteratingSystem<GridRenderN>{
	var creator:EntityCreator;
	var container:DisplayObjectContainer;
	
	public function new(container:DisplayObjectContainer){
		super(GridRenderN, updateN, add, remove);
		this.container = container;
	}
	
	function add(node:GridRenderN){
		node.grid.tiles.walk(function(current:Tile,x,y){
			for(tileItem in current.stack){
				onTileItemAdded(current, tileItem);
			}
			current.onTileItemAdded.add(onTileItemAdded);
			return current;
		});
	}
	
	function onTileItemAdded(tile:Tile, tileItem:TileItem){
		tileItem.textField = new TextField(50, 50, tileItem.number + "");
		tileItem.textField.x = tile.pos.x * 50;
		tileItem.textField.y = tile.pos.y * 50;
		tileItem.textField.color = 0xffffff;
		container.addChild(tileItem.textField);
	}
	
	function remove(node:GridRenderN){
		
	}
	
	function updateN(node:GridRenderN, time:Float){
		
	}
}
