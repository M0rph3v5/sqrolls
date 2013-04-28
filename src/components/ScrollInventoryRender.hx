package components;

using Imports;

class ScrollInventoryRender {
	public var displayObjectContainer:DisplayObjectContainer;
	
	public var images:Array<Image>;
		
	public function new(dpo:DisplayObjectContainer){
		this.displayObjectContainer = dpo;
		images = new Array();
	}
}