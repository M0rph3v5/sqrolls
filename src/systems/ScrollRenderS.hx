package systems;

using Imports;

class ScrollRenderN extends Node<ScrollRenderN>{
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
		
	}
	
	public function remove(node:ScrollRenderN){
		
	}
	
	public function updateN(node:ScrollRenderN, time:Float){
		
	}
}