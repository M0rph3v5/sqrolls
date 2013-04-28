using Imports;

class LevelGen {
	var width:Int;
	var height:Int;
	
	var scrolls:Array<Array<Int>>;
	
	public var goals: Array<Array<Int>>;
	public var grid: Array2<Int>;
	
	public function new(width:Int, height:Int){
		this.width = width;
		this.height = height;
		
		
		grid = new Array2(6,6);
		scrolls = [[1,2,3,4,5], [5,4,3,2,1]];
	}
	
	public function generate(){
		goals = [[5,4,4],[1,2,5],[1,2]];
		return;
		
		var dirX = Random.randRange(0,1);
		var dirY = 1 - dirX;
		
		var startX = Random.randRange(0,5);
		var startY = Random.randRange(0,5);
		
		for(i in 0...4){
			var start = dirX == 1 ? startX : startY;
			
			var randomLength = Random.randRange(2,6);

			var min = M.max(start-randomLength+1, 0);
			var max = M.min(start+randomLength-1, 5);
			
			start = Random.randRange(min,max);

			if(start + (randomLength - 1) > 5){
				start = 6 - randomLength;
			}
			
			startX = dirX == 1 ? start : startX;
			startY = dirY == 1 ? start : startY; 

			var scroll = scrolls[Random.randRange(0, scrolls.length - 1)];
			
			if(Random.randRange(0,1) == 0){
				addScroll(startX, startY, dirX, dirY, scroll, randomLength);
			}else{
				addScroll(startX, startY, dirX, dirY, scroll, randomLength);
			}
			
			startX += Random.randRange(0, randomLength - 1) * dirX;
			startY += Random.randRange(0, randomLength - 1) * dirY;
						
			dirX = 1 - dirX;
			dirY = 1 - dirY;
		}
		
		trace(grid);
	}
	
	function addScroll(startX:Int, startY:Int, dirX:Int, dirY:Int, scroll:Array<Int>, length:Int){
		var i:Int = 0;
		
		for(i in 0...length-1){
			grid.set(startX, startY, scroll[i]);
			startX += dirX;
			startY += dirY;
		}
		grid.set(startX, startY, 0);
	}
}
