package components;

using Imports;

class Scroll {
	
	public var tileItems:Array<Entity>;
	public var data:Array<Int>;
	public var beginPoint:Vec2;
	public var endPoint:Vec2;
	public var dragging:Bool;
	
	public var grid:Grid;
			
	public function new(grid:Grid, data:Array<Int>, ?beginPoint:Vec2){
		if (beginPoint == null)
			beginPoint = new Vec2(0,0);
		
		this.beginPoint = beginPoint;
		this.endPoint = beginPoint.copy();
		this.grid = grid;
		tileItems = new Array();
	}
}