package components;

using Imports;

class ScoreUIRender {
	public var displayObjectContainer:DisplayObjectContainer;
	public var grid:Grid;

	public var tf:TextField;
		
	public function new(dpo:DisplayObjectContainer, grid:Grid){
		this.displayObjectContainer = dpo;
		this.grid = grid;
	}
}
