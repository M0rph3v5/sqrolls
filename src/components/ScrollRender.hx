package components;

using Imports;

class ScrollRender {
	public var displayObjectContainer:DisplayObjectContainer;
	
	public var image:Image;
	public var imageOffset:Mat23;
	
	public function new(dpo:DisplayObjectContainer){
		this.displayObjectContainer = dpo;
		this.imageOffset = new Mat23();
	}
}
