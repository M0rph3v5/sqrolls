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
		
		if (node.scroll.data[0] != 0) {
			node.scrollRender.image.color = switch(node.scroll.data[0]){
				case(1):Game.greenColor; // to scroll
				case(4):Game.blueColor; // reverse scroll
				case(_):0;
			}
		}
	}
	
	public function remove(node:ScrollRenderN){
		node.scrollRender.displayObjectContainer.removeChild(node.scrollRender.image);
	}
	
	public function updateN(node:ScrollRenderN, time:Float){
		var transform:Mat23 = new Mat23();
		transform = transform.concat(Mat23.scale(((node.scroll.tileItems.length) * 84) / node.scrollRender.image.texture.width, 1));

		transform = transform.concat(Mat23.translation(-84.0/2, -84.0/2));
		if(node.scroll.beginPoint.x == node.scroll.endPoint.x){
			if(node.scroll.beginPoint.y <= node.scroll.endPoint.y){
				transform = transform.concat(Mat23.rotation(Math.PI / 2));
			}else{
				transform = transform.concat(Mat23.rotation(-Math.PI / 2));
			}
		}else{
			if(node.scroll.beginPoint.x <= node.scroll.endPoint.x){
			}else{
				transform = transform.concat(Mat23.rotation(Math.PI));
			}
		}
		transform = transform.concat(Mat23.translation(84.0/2, 84.0/2));
		
		transform.toMatrix(node.scrollRender.image.transformationMatrix);
	}
}