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
			current.onChanged.add(onTileChanged);
			return current;
		});
	}
	
	function onTileChanged(tile:Tile){
		/*var textField:TextField = new TextField(50,50,"9");
		textField.x = 100;
		textField.color = 0xffffff;
		container.addChild(textField);*/		
	}
	
	function remove(node:GridRenderN){
		
	}
	
	function updateN(node:GridRenderN, time:Float){
		
	}
}
