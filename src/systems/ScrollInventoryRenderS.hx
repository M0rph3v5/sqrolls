package systems;

using Imports;

class ScrollInventoryRenderN extends Node<ScrollInventoryRenderN>{
	public var scrollInventoryRender:ScrollInventoryRender;
	public var scrollInventory:ScrollInventory;
	public var transform:Transform;
}

class ScrollInventoryRenderS extends ListIteratingSystem<ScrollInventoryRenderN>{
	var graphics:Graphics;
	
	public function new(graphics:Graphics){
		super(ScrollInventoryRenderN, updateN, add, remove);
		this.graphics = graphics;
	}

	public function add(node:ScrollInventoryRenderN){
	}
	
	public function remove(node:ScrollInventoryRenderN){
		
	}
	
	public function updateN(node:ScrollInventoryRenderN, time:Float){
		
	}
}