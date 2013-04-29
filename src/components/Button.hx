package components;

using Imports;

class Button {
	public var mouseOver:Bool;
	public var down:Bool;
	
	public var pressed:Bool;
	
	public var wasDown:Bool;
	
	public var area : Rectangle;
	
	public function new(rect:Rectangle){
		this.area = rect;
	}
}
