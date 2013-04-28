package systems;

using Imports;

class ScrollInventoryItemRenderN extends Node<ScrollInventoryItemRenderN>{
	public var scrollInventoryItemRender:ScrollInventoryItemRender;
	public var scrollInventoryItem:ScrollInventoryItem;
	public var transform:Transform;
	public var scrollInventoryCitizen:ScrollInventoryCitizen;
}

class ScrollInventoryItemRenderS extends ListIteratingSystem<ScrollInventoryItemRenderN>{
	var graphics:Graphics;
	
	public function new(graphics:Graphics){
		super(ScrollInventoryItemRenderN, updateN, add, remove);
		this.graphics = graphics;
	}
	
	public function add(node:ScrollInventoryItemRenderN){
		node.scrollInventoryItemRender.image = new Image(graphics.getTexture("scroll-closed"));
		if (node.scrollInventoryItem.data[0] != 0) {
			node.scrollInventoryItemRender.image.color = switch(node.scrollInventoryItem.data[0]) {				
				case(1):0x8aff00; // to scroll
				case(5):0x0d8fea; // reverse scroll
				case(_):0;
			}				
		}
		node.scrollInventoryItemRender.displayObjectContainer.addChild(node.scrollInventoryItemRender.image);
		
		node.scrollInventoryItemRender.tf = new TextField(85,85,node.scrollInventoryItem.count+"");
		node.scrollInventoryItemRender.tf.color = 0xffffff;
		node.scrollInventoryItemRender.tf.fontSize = 30;
		node.scrollInventoryItemRender.displayObjectContainer.addChild(node.scrollInventoryItemRender.tf);		
		
		var index = Lambda.indexOf(node.scrollInventoryCitizen.scrollInventory.items, node.entity);
		node.transform.transform.tx = index * 80 + 85;
		node.transform.transform.ty = 82;
	}
	
	public function remove(node:ScrollInventoryItemRenderN){
		//node.scrollInventoryItemRender.displayObjectContainer.removeChild(node.scrollInventoryItemRender.image);
	}
	
	public function updateN(node:ScrollInventoryItemRenderN, time:Float){
		node.scrollInventoryItemRender.tf.text = node.scrollInventoryItem.count + "";
	}
}