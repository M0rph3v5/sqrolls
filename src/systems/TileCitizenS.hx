package systems;

using Imports;

class TileCitizenN extends Node<TileCitizenN>{
	public var tileCitizen:TileCitizen;
}

class TileCitizenS extends ListIteratingSystem<TileCitizenN>{
	public function new(){
		super(TileCitizenN, updateN, add, remove);
	}
	
	public function add(node:TileCitizenN){
		node.tileCitizen.tile.stack.push(node.entity);
	}
	
	public function remove(node:TileCitizenN){
		node.tileCitizen.tile.stack.remove(node.entity);
	}
	
	public function updateN(node:TileCitizenN, time:Float){
		
	}
}
