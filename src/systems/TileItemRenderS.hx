package systems;

using Imports;

class TileItemRenderN extends Node<TileItemRenderN>{
	public var gridCitizen:GridCitizen;
	public var tileItem:TileItem;
	public var tileItemRender:TileItemRender;
	public var transform:Transform;
}

class TileItemRenderS extends ListIteratingSystem<TileItemRenderN>{
	var graphics:Graphics;
	
	public function new(graphics:Graphics){
		super(TileItemRenderN, updateN, add, remove);
		this.graphics = graphics;
	}
	
	public function add(node:TileItemRenderN){
		
		if (node.tileItem.number == 0)
			return;
		
		node.tileItemRender.image = new Image(graphics.getTextureSymbolForNumber(node.tileItem.number));
		node.tileItemRender.displayObjectContainer.addChild(node.tileItemRender.image);
		
		//node.tileItemRender.displayObjectContainer.filter = BlurFilter.createGlow(0xffffff, 0.5); 
				
		var pos = Utils.positionForCoord(node.gridCitizen.pos);
		pos.x += 18;
		pos.y += 18;
		node.transform.position = pos;
	}
	
	public function remove(node:TileItemRenderN){
//		node.tileItemRender.displayObjectContainer.removeChild(node.tileItemRender.tf);
	}
	
	public function updateN(node:TileItemRenderN, time:Float){
		
	}
}