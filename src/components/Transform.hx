package components;

using Imports;

class Transform {
	public var transform:Mat23;
	public var position(get, set):Vec2;
	function get_position() {
		return new Vec2(transform.tx, transform.ty);
	}
	function set_position(pos:Vec2) {
		transform.tx = pos.x;
		transform.ty = pos.y;
		return pos;
	}
	
	public function new(){
		transform = new Mat23();
	}
}
