package components;

using Imports;

class NextLevelButton {
	public var dpo:DisplayObjectContainer;
	
	public var enabled:Image;
	public var disabled:Image;
	
	public function new(dpo:DisplayObjectContainer){
		this.dpo = dpo;
	}
}
