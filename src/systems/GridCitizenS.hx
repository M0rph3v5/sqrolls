package systems;

using Imports;

class GridCitizenN extends Node<GridCitizenN>{
	public var gridCitizen:GridCitizen;
}

class GridCitizenS extends ListIteratingSystem<GridCitizenN>{
	public function new(){
		super(GridCitizenN, updateN, add, remove);
	}
	
	public function add(node:GridCitizenN){
		
		var gc = node.gridCitizen;
		gc.grid.tiles.get(Std.int(gc.pos.x), Std.int(gc.pos.y)).push(node.entity);
	}
	
	public function remove(node:GridCitizenN){
		var gc = node.gridCitizen;
		gc.grid.tiles.get(Std.int(gc.pos.x), Std.int(gc.pos.y)).remove(node.entity);
	}
	
	public function updateN(node:GridCitizenN, time:Float){
		
	}
}
