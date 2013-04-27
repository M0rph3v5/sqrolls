package components;

using Imports;

class Transform {
	public var transform:Mat23;
	public var position(get, null):Vec2;
	function get_position() {
		return new Vec2(transform.tx, transform.ty);
	}
	
	public function new(){
		transform = new Mat23();
	}
}
