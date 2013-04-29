package systems;

using Imports;

@:font("assets/Sqrolls/Courgette-Regular.ttf") class MyFont extends flash.text.Font {	 
}

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
			if (itemNode.scrollInventoryItem.mouseSlave) { // skip the cursor thingey
				continue;
			}
			
			var rect = new Rectangle(itemNode.transform.position.x, itemNode.transform.position.y, 85, 85);
			if(rect.contains(pos.x, pos.y)) {	
				var activeScroll = itemNode.gameCitizen.game.activeScrollInventoryItem;
				if (activeScroll != null && activeScroll.data[0] == itemNode.scrollInventoryItem.data[0]) {
					putActiveScrollBackInInventory(itemNode);
				} else {
					selectScrollNode(itemNode, pos);				
				}
			}
		}
	}
	
	function selectScrollNode(itemNode:ScrollInventoryItemRenderN, pos:Vec2, ?refund:Bool = false) {
		var activeScroll = itemNode.gameCitizen.game.activeScrollInventoryItem;

		putActiveScrollBackInInventory(itemNode);
		
		if (itemNode.scrollInventoryItem.count <= 0 && !refund) {
			SoundManager.get_instance().error();			
			return;
		}
		
		activeScroll = itemNode.scrollInventoryItem;
		if (!refund)
			activeScroll.count--;
		creator.createInventoryItem(0, itemNode.gameCitizen.game, itemNode.scrollInventoryCitizen.scrollInventory, itemNode.scrollInventoryItem.data, 0, true, pos);
		itemNode.gameCitizen.game.activeScrollInventoryItem = activeScroll;
		
		SoundManager.get_instance().take();
	}
	
	function putActiveScrollBackInInventory(itemNode:ScrollInventoryItemRenderN) {
		var activeScroll = itemNode.gameCitizen.game.activeScrollInventoryItem;		
				
		// check the last one
		if (activeScroll != null) { // if it's still active, refund cus i'm selecting a new one.
			activeScroll.count++;
			activeScroll = null;
			itemNode.gameCitizen.game.activeScrollInventoryItem = null;
		}
		
		for (inode in itemList) {
			if (inode.scrollInventoryItem.mouseSlave) {
				engine.removeEntity(inode.entity);
				break;	
			}
		}

		SoundManager.get_instance().release();
	}
	
	function onMouseMove(pos:Vec2, mouseDown:Bool) {
		for (inode in itemList) {
			if (inode.scrollInventoryItem.mouseSlave) {
				inode.transform.position = pos;
				break;
			}
		}
	}
	
	public function add(node:ScrollInventoryItemRenderN){
		node.scrollInventoryItemRender.image = new Image(graphics.getTexture("scroll-closed"));
		if (node.scrollInventoryItem.data[0] != 0) {
			node.scrollInventoryItemRender.image.color = switch(node.scrollInventoryItem.data[0]) {				
				case(1):Game.greenColor; // to scroll
				case(4):Game.blueColor; // reverse scroll
				case(_):0;
			}
		}
		node.scrollInventoryItemRender.displayObjectContainer.addChild(node.scrollInventoryItemRender.image);
		
		if (!node.scrollInventoryItem.mouseSlave) {
			node.scrollInventoryItemRender.notAllowedImage = new Image(graphics.getTexture("not-allowed"));
			node.scrollInventoryItemRender.notAllowedImage.x = 14;
			node.scrollInventoryItemRender.notAllowedImage.y = 14;
			node.scrollInventoryItemRender.displayObjectContainer.addChild(node.scrollInventoryItemRender.notAllowedImage);
						
			var x = 40;
			var y = 4;
			node.scrollInventoryItemRender.invEmptyImage = new Image(graphics.getTexture("inventory-unavailable-scroll-indicator"));
			node.scrollInventoryItemRender.invEmptyImage.x = x;
			node.scrollInventoryItemRender.invEmptyImage.y = y;
			node.scrollInventoryItemRender.displayObjectContainer.addChild(node.scrollInventoryItemRender.invEmptyImage);
			node.scrollInventoryItemRender.invImage = new Image(graphics.getTexture("inventory-available-scroll-indicator"));
			node.scrollInventoryItemRender.invImage.x = x;
			node.scrollInventoryItemRender.invImage.y = y;
			node.scrollInventoryItemRender.displayObjectContainer.addChild(node.scrollInventoryItemRender.invImage);
			
			node.scrollInventoryItemRender.tf = new TextField(85,85,node.scrollInventoryItem.count+"");
			node.scrollInventoryItemRender.tf.color = 0xffffff;
			node.scrollInventoryItemRender.tf.fontSize = 13;
			node.scrollInventoryItemRender.tf.fontName = "Courgette Regular";
			node.scrollInventoryItemRender.tf.x = x - 31;
			node.scrollInventoryItemRender.tf.y = y - 30;
			node.scrollInventoryItemRender.displayObjectContainer.addChild(node.scrollInventoryItemRender.tf);		
			
			//var index = Lambda.indexOf(node.scrollInventoryCitizen.scrollInventory.items, node.entity);
			var index = node.scrollInventoryCitizen.index;
			//index = Random.randRange(1,10);
			node.transform.transform.tx = index * 84 + 50;
			node.transform.transform.ty = 75;
		} 
		
	}
	
	public function remove(node:ScrollInventoryItemRenderN){

		//node.scrollInventoryItemRender.displayObjectContainer.removeChild(node.scrollInventoryItemRender.image);
	}
	
	public function updateN(node:ScrollInventoryItemRenderN, time:Float){
		
		if (!node.scrollInventoryItem.mouseSlave) {
			if (node.gameCitizen.game.refund > -1 && node.gameCitizen.game.refund == node.scrollInventoryItem.data[0]) {
				selectScrollNode(node, mouseInput.lastMousePos, true);
				node.gameCitizen.game.refund = -1;			
			}
			node.scrollInventoryItemRender.tf.text = node.scrollInventoryItem.count + "";
			node.scrollInventoryItemRender.tf.color =node.scrollInventoryItem.count == 0 ? 0x11111 : 0xffffff;
			node.scrollInventoryItemRender.invEmptyImage.visible = node.scrollInventoryItem.count == 0;
			node.scrollInventoryItemRender.invImage.visible = node.scrollInventoryItem.count != 0;
			
			node.scrollInventoryItemRender.image.visible = node.scrollInventoryItem.count != 0;
			node.scrollInventoryItemRender.notAllowedImage.visible = node.scrollInventoryItem.count == 0; 
		} else {
			if (node.gameCitizen.game.activeScrollInventoryItem == null) { // null and active is dead, destroy mouseslave
				for (inode in itemList) {
					if (inode.scrollInventoryItem.mouseSlave) {
					engine.removeEntity(inode.entity);
					break;	
				}
		}
			}
		}
	}
}