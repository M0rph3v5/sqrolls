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
		
		var filter = BlurFilter.createGlow(0xffffff, 0.0);
		node.tileItemRender.displayObjectContainer.filter = filter;
				
		var pos = Utils.positionForCoord(node.gridCitizen.pos);
		pos.x += 18;
		pos.y += 18;
		node.transform.position = pos;
	}
	
	public function remove(node:TileItemRenderN){
//		node.tileItemRender.displayObjectContainer.removeChild(node.tileItemRender.tf);
		Actuate.stop(node.tileItemRender.displayObjectContainer.filter);
	}
	
	public function updateN(node:TileItemRenderN, time:Float){
		
		if ((node.tileItem.achieved && node.tileItemRender.animationState == 0) || (!node.tileItem.achieved && node.tileItemRender.animationState == 2)) {
			node.tileItemRender.animationState = 1;
			
			var filter = cast(node.tileItemRender.displayObjectContainer.filter, BlurFilter);
			var achievedAtThisPoint = node.tileItem.achieved;
			Actuate.update(filter.setUniformColor, 0.3, [true, 0xffffff, achievedAtThisPoint?0.0:1.0], [true, 0xffffff, achievedAtThisPoint?1.0:0.0]).onComplete(function() {
				node.tileItemRender.animationState = achievedAtThisPoint?2:0;
			});
		}
	}
	
}