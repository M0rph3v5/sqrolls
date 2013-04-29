package components;

using Imports;

class TileItemRender {
	public var displayObjectContainer:DisplayObjectContainer;
	
	public var tf:TextField;
	public var image:Image;
	
	public function new(dpo:DisplayObjectContainer){
		this.displayObjectContainer = dpo;
	}
}
