package components;

using Imports;

class MuteButton {
	public var dpo:DisplayObjectContainer;
	
	public var enabled:Image;
	public var disabled:Image;
	
	public function new(dpo:DisplayObjectContainer){
		this.dpo = dpo;
	}
}
