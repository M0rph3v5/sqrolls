package systems;

using Imports;

class TileItemRenderN extends Node<TileItemRenderN>{
	public var gridCitizen:GridCitizen;
	public var tileItem:TileItem;
	public var tileItemRender:TileItemRender;
	public var transform:Transform;
}

class TileItemRenderS extends ListIteratingSystem<TileItemRenderN>{
	public function new(){
		super(TileItemRenderN, updateN, add, remove);
	}
	
	public function add(node:TileItemRenderN){
		
		node.tileItemRender.tf = new TextField(85,85, node.tileItem.number == 0 ? "" : node.tileItem.number+"");
		node.tileItemRender.tf.color = 0xffffff;
		node.tileItemRender.tf.fontSize = 30;
		node.tileItemRender.displayObjectContainer.addChild(node.tileItemRender.tf);
		node.transform.position = Utils.positionForCoord(node.gridCitizen.pos);
	}
	
	public function remove(node:TileItemRenderN){
		node.tileItemRender.displayObjectContainer.removeChild(node.tileItemRender.tf);
	}
	
	public function updateN(node:TileItemRenderN, time:Float){
		
	}
}