using Imports;

class Utils {
	public static function coordForPosition(pos:Vec2) {
		return new Vec2(Math.floor((pos.x - 76) / 85), Math.floor((pos.y - 183) / 85));		
	}

	public static function positionForCoord(pos:Vec2) {
		return new Vec2(pos.x * 85 + 76, pos.y * 85 + 183);
	}
	
}