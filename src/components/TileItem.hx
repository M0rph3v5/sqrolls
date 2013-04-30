package components;

using Imports;

class TileItem {
	
	public var number:Int;
	public var achieved:Bool;
	public var extragonous:Bool;
	public var goals:Array<Entity>;
	
	public function new(number:Int){
		this.number = number;
		goals = new Array();
	}
}
