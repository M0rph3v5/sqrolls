package systems;

using Imports;

class ScrollInventoryItemRenderN extends Node<ScrollInventoryItemRenderN>{
	public var scrollInventoryItemRender:ScrollInventoryItemRender;
	public var scrollInventoryItem:ScrollInventoryItem;
	public var transform:Transform;
	public var scrollInventoryCitizen:ScrollInventoryCitizen;
	public var gameCitizen:GameCitizen;
}

class ScrollInventoryItemRenderS extends ListIteratingSystem<ScrollInventoryItemRenderN>{
	var graphics:Graphics;
	var mouseInput:MouseInput;
	var itemList:NodeList<ScrollInventoryItemRenderN>;
	var activeScrollNode:ScrollInventoryItemRenderN;
	var mouseSlaveNode:ScrollInventoryItemRenderN;
	var creator:EntityCreator;
	var engine:Engine;
	
	public function new(graphics:Graphics, mouseInput:MouseInput, creator:EntityCreator){
		super(ScrollInventoryItemRenderN, updateN, add, remove);
		this.graphics = graphics;
		this.creator = creator;
		this.mouseInput = mouseInput;
		this.mouseInput.onMouseDown.add(onMouseDown);
		this.mouseInput.onMouseUp.add(onMouseUp);
		this.mouseInput.onMouseMove.add(onMouseMove);
	}
	
	override public function addToEngine(engine:Engine){
		super.addToEngine(engine);
		itemList = engine.getNodeList(ScrollInventoryItemRenderN);
		this.engine = engine;
	}
		
	function onMouseDown(pos:Vec2) {
		
	}
	
	function onMouseUp(pos:Vec2) {
		
		// check if hitting one of the invetory items
		for (itemNode in itemList) {
			if (itemNode.scrollInventoryItem.mouseSlave)
			 continue;
			
			var rect = new Rectangle(itemNode.transform.position.x, itemNode.transform.position.y, 85, 85);
			if(rect.contains(pos.x, pos.y)) {
				trace(rect);
				
				// check the last one
				if (activeScrollNode != null) { // if it's still active, refund cus i'm selecting a new one.
					activeScrollNode.scrollInventoryItem.count++;
					activeScrollNode = null;
				}
				
				if (mouseSlaveNode != null) {
					engine.removeEntity(mouseSlaveNode.entity);
				}
				
				activeScrollNode = itemNode;
				activeScrollNode.scrollInventoryItem.count--;
				creator.createInventoryItem(itemNode.gameCitizen.game, itemNode.scrollInventoryCitizen.scrollInventory, itemNode.scrollInventoryItem.data, itemNode.scrollInventoryItem.count, true);
				activeScrollNode.gameCitizen.game.activeScrollInventoryItem = activeScrollNode.scrollInventoryItem;
			}
		}
	}
	
	function onMouseMove(pos:Vec2, mouseDown:Bool) {
		if (mouseSlaveNode == null) {
			return;
		}
		
		mouseSlaveNode.transform.position = pos;
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
		
		if (!node.scrollInventoryItem.mouseSlave) {			
			node.scrollInventoryItemRender.tf = new TextField(85,85,node.scrollInventoryItem.count+"");
			node.scrollInventoryItemRender.tf.color = 0xffffff;
			node.scrollInventoryItemRender.tf.fontSize = 30;
			node.scrollInventoryItemRender.displayObjectContainer.addChild(node.scrollInventoryItemRender.tf);		
			
			var index = Lambda.indexOf(node.scrollInventoryCitizen.scrollInventory.items, node.entity);
			node.transform.transform.tx = index * 80 + 85;
			node.transform.transform.ty = 82;
		} else {
			mouseSlaveNode = node;
		}
		
	}
	
	public function remove(node:ScrollInventoryItemRenderN){
		//node.scrollInventoryItemRender.displayObjectContainer.removeChild(node.scrollInventoryItemRender.image);
	}
	
	public function updateN(node:ScrollInventoryItemRenderN, time:Float){
		if (!node.scrollInventoryItem.mouseSlave)
			node.scrollInventoryItemRender.tf.text = node.scrollInventoryItem.count + "";
	}
}