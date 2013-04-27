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
		gridCitizen.grid.tiles.push(node.entity);
	}
	
	public function remove(node:GridCitizenN){
		gridCitizen.grid.tiles.remove(node.entity);
	}
	
	public function updateN(node:GridCitizenN, time:Float){
		
	}
}
