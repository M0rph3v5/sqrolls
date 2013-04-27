package systems;

class CoordN extends Node<CoordN>{
	public var coord:Coord;
	public var transform:Tansform;
}

class CoordS extends ListIteratingSystem<CoordN>{
	public function new(){
		super(CoordN, updateN);
	}
	
	function updateN(node:CoordN, time:Float){
		transform.position = 
	}
}
