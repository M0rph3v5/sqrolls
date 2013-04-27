package systems;

using Imports;

class ScrollRenderN extends Node<ScrollRenderN>{
	public var scroll:Scroll;
	public var scrollRender:ScrollRender;
}

class ScrollRenderS extends ListIteratingSystem<ScrollRenderN>{
	var graphics:Graphics;
	
	public function new(graphics:Graphics){
		super(ScrollRenderN, updateN, add, remove);
		this.graphics = graphics;
	}
	
	public function add(node:ScrollRenderN){
		node.scrollRender.image = new Image(graphics.getTexture("scroll-open"));
		node.scrollRender.displayObjectContainer.addChild(node.scrollRender.image);
		
		node.scrollRender.image.x += 85.0 / 2;
		node.scrollRender.image.y += 85.0 / 2;
		node.scrollRender.image.pivotX = 85.0 / 2;
		node.scrollRender.image.pivotY = 85.0 / 2;

		if(node.scroll.beginPoint.x != node.scroll.endPoint.x){
			node.scrollRender.image.rotation = Math.PI / 2;
		}

	}
	
	public function remove(node:ScrollRenderN){
		node.scrollRender.displayObjectContainer.removeChild(node.scrollRender.image);
	}
	
	public function updateN(node:ScrollRenderN, time:Float){
		
	}
}