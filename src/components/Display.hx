package components;

using Imports;

class Display {
	public var displayObject(default, null):DisplayObject;
	public var offset:Mat23;
	public var depth:Float = 0;
	
	public function new(dpo:DisplayObject, offset:Mat23, ?depth:Float){
		this.displayObject = dpo;
		this.offset = offset;
		this.depth = depth;
	}
}
