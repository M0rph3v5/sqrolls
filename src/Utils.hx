using Imports;

class Utils {

	public static function coordForPosition(pos:Vec2) {
		return new Vec2(Math.floor(pos.x / 50), Math.floor(pos.y / 50));		
	}

	public static function positionForCoord(pos:Vec2) {
		return new Vec2(pos.x * 50, pos.y * 50);
	}
	
}