package components;

using Imports;

class Game {
	public static var greenColor:Int = 0x47b809;
	public static var blueColor:Int = 0x459dff;
	
	public var activeScrollInventoryItem:ScrollInventoryItem = null;
	public var goals:Array<Entity>;
	public var refund:Int = -1;
	public var grid:Grid;
	
	public var achieved:Bool = false;
	public var cleanAchieved:Bool = false;
	public var nextLevelButtonPressed:Bool = false;
	
	public var level:Int;
	
	public function new(level:Int){
		goals = new Array();
		this.level = level;
	}
}
