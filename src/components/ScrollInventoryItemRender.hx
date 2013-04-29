package components;

using Imports;

class ScrollInventoryItemRender {
	public var displayObjectContainer:DisplayObjectContainer;
	public var image:Image;
	public var tf:TextField;
	
	public var invEmptyImage:Image;
	public var invImage:Image;
	
	public var notAllowedImage:Image;
	
	public function new(dpo:DisplayObjectContainer){
		this.displayObjectContainer = dpo;
	}
}