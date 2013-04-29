package components;

using Imports;

class GoalRender {
	public var dpo:DisplayObjectContainer;
	
	public var tf:TextField;	
	public var symbolImages:Array<Image>;
	public var correctImage:Image;
	
	public function new(dpo:DisplayObjectContainer){
		this.dpo = dpo;
		symbolImages = new Array();
	}
}
