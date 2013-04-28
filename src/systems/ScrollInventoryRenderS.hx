package systems;

using Imports;

class ScrollInventoryRenderN extends Node<ScrollInventoryRenderN>{
	public var scrollInventoryRender:ScrollInventoryRender;
	public var scrollInventory:ScrollInventory;
}

class ScrollInventoryRenderS extends ListIteratingSystem<ScrollInventoryRenderN>{
	var graphics:Graphics;
	
	public function new(graphics:Graphics){
		super(ScrollInventoryRenderN, updateN, add, remove);
		this.graphics = graphics;
	}

	public function add(node:ScrollInventoryRenderN){
		
		
		var x = 85.0;
		for (scrollData in node.scrollInventory.availableScrolls) {
			var image = new Image(graphics.getTexture("scroll-closed"));
			if (scrollData[0] != 0) {
				image.color = switch(scrollData[0]) {				
					case(1):0x8aff00; // to scroll
					case(5):0x0d8fea; // reverse scroll
					case(_):0;
				}				
			}
			
			image.x = x;
			image.y = 80;
			node.scrollInventoryRender.images.push(image);
			node.scrollInventoryRender.displayObjectContainer.addChild(image);
			
			x += image.width + 22;
		}

	}
	
	public function remove(node:ScrollInventoryRenderN){
		for (image in node.scrollInventoryRender.images) {
			node.scrollInventoryRender.displayObjectContainer.removeChild(image);
		}
	}
	
	public function updateN(node:ScrollInventoryRenderN, time:Float){
		
	}
}