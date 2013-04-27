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
		tileCitizen.tile.stack.push(node);
	}
	
	public function remove(node:TileCitizenN){
		tileCitizen.tile.stack.remove(node);
	}
	
	public function updateN(node:TileCitizenN, time:Float){
		
	}
}
