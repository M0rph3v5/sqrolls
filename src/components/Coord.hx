package components;

class Coord {
	public var coord:Vec2;
	
	public function new(?coord:Vec2){
		if(coord == null){
			coord = new Vec2();
		}
		this.coord = coord;
	}
}
