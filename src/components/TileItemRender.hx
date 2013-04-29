package components;

using Imports;

class TileItemRender {
	public var displayObjectContainer:DisplayObjectContainer;
	
	public var tf:TextField;
	public var image:Image;
	
	public var animationState:Int = 0;
	
	public function new(dpo:DisplayObjectContainer){
		this.displayObjectContainer = dpo;
	}
}
