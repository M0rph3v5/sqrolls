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
	}
	
	public function remove(node:ScrollRenderN){
		node.scrollRender.displayObjectContainer.removeChild(node.scrollRender.image);
	}
	
	public function updateN(node:ScrollRenderN, time:Float){
		var transform:Mat23 = new Mat23();
		transform = transform.concat(Mat23.scale(((node.scroll.tileItems.length + 1) * 85) / node.scrollRender.image.texture.width, 1));

		if(node.scroll.beginPoint.x == node.scroll.endPoint.x){
			transform = transform.concat(Mat23.translation(-85.0/2, -85.0/2));
			transform = transform.concat(Mat23.rotation(Math.PI / 2)); 
			transform = transform.concat(Mat23.translation(85.0/2, 85.0/2));
		}else{
			node.scrollRender.image.rotation = 0;
		}
		
		transform.toMatrix(node.scrollRender.image.transformationMatrix);
	}
}