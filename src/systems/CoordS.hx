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
		node.transform.position = Utils.positionForCoord(node.coord.coord);
	}
}
