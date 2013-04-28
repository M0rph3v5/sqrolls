package components;

using Imports;

class Game {
	public var activeScrollInventoryItem:ScrollInventoryItem = null;
	public var goals:Array<Entity>;
	public var refund:Int = -1;
	public var grid:Grid;

	public function new(){
		goals = new Array();	
	}
}
