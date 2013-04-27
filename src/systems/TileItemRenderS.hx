package systems;

using Imports;

class TileItemRenderN extends Node<TileItemRenderN>{
	public var tileCitizen:TileCitizen;
	public var gridCitizen:GridCitizen;
	public var tileItem:TileItem;
	public var tileItemRender:TileItemRender;
	public var display:Display;
	public var transform:Transform;
}

class TileItemRenderS extends ListIteratingSystem<TileItemRenderN>{
	public function new(){
		super(TileItemRenderN, updateN, add, remove);
	}
	
	public function add(node:TileItemRenderN){
		node.tileItemRender.tf = new TextField(50,50,node.tileItem.number+"");
		node.tileItemRender.tf.color = 0xffffff;
		node.tileItemRender.displayObjectContainer.addChild(node.tileItemRender.tf);
		node.transform.transform.tx = node.gridCitizen.pos.x * 50;
		node.transform.transform.ty = node.gridCitizen.pos.y * 50;
	}
	
	public function remove(node:TileItemRenderN){
		node.tileItemRender.displayObjectContainer.removeChild(node.tileItemRender.tf);
	}
	
	public function updateN(node:TileItemRenderN, time:Float){
		
	}
}