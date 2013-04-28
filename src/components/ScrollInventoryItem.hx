package components;

class ScrollInventoryItem {
	public var data:Array<Int>;
	public var count:Int;
	
	public var mouseSlave:Bool;
	
	public function new(data:Array<Int>, count:Int, mouseSlave:Bool) {
		this.data = data;
		this.count = count;
		this.mouseSlave = mouseSlave;
	}
}
