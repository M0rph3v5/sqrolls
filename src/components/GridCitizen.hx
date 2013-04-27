package components;

using Imports;

class GridCitizen {
	public var grid:Grid;
	public var pos:Vec2;
	
	public function new(grid:Grid, pos:Vec2){
		this.grid = grid;
		this.pos = pos;
	}
}
