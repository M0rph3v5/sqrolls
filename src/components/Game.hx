package components;

using Imports;

class Game {
	public var activeScrollInventoryItem:ScrollInventoryItem = null;
	public var goals:Array<Entity>;
	public var grid:Grid;

	public function new(){
		goals = new Array();	
	}
}
