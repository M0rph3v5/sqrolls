using Imports;

class Utils {
	public static function coordForPosition(pos:Vec2, grid:Grid) {
		var x = Math.floor((pos.x - 50) / 85);
		var y = Math.floor((pos.y - 183) / 85);
		
		if (x < 0 || x >= grid.columns)
			return null;
		if (y < 0 || y >= grid.rows)
			return null;
			
		return new Vec2(x, y);
	}

	public static function positionForCoord(pos:Vec2) {
		return new Vec2(pos.x * 85 + 43, pos.y * 85 + 180);
	}
	
}