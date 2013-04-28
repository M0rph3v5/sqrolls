package systems;

using Imports;

class ScrollInventoryCitizenN extends Node<ScrollInventoryCitizenN>{
	public var scrollInventoryCitizen:ScrollInventoryCitizen;
}

class ScrollInventoryCitizenS extends ListIteratingSystem<ScrollInventoryCitizenN>{
	public function new(){
		super(ScrollInventoryCitizenN, updateN, add, remove);
	}
	
	public function add(node:ScrollInventoryCitizenN){
		node.scrollInventoryCitizen.scrollInventory.items.push(node.entity);
	}
	
	public function remove(node:ScrollInventoryCitizenN){
		node.scrollInventoryCitizen.scrollInventory.items.remove(node.entity);
	}
	
	public function updateN(node:ScrollInventoryCitizenN, time:Float){
		
	}
}
