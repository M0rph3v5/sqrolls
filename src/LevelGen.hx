using Imports;

class GenConfig{
	public var width:Int;
	public var height:Int;
	public var scrolls:Array<Array<Int>>;
	public var zeroScroll:Array<Int>;
	public var numScrolls:Int;
	public var numBlanks:Int;
	public var numConvenient:Int;
	public var convenients:Array<Int>;
	public var numInconvenient:Int;
	public var inconvenients:Array<Int>;
	
	public function new(){
	
	}
}

class Point{
	public var x:Int;
	public var y:Int;
	public function new(x:Int, y:Int){
		this.x = x;
		this.y = y;
	}
	
	public function toString():String{
		return '<$x,$y>';
	}
}

class LevelGen {
	var c:GenConfig;
	
	public var grid: Array2<Int>;

	public var empty : Array<Point>;
 	public var emptyGrid : Array2<Point>;
	public var potentialScrollStarts : Array<Point>;
	
	public var goals: Array<Array<Int>>;

	public function new(width:Int, height:Int){
		this.c = new GenConfig();
		c.width = 4;
		c.height = 4;
		c.scrolls = [[1,2,3,4,5], [5,4,3,2,1]];
		c.zeroScroll = [0,0,0,0,0];
		
		c.numScrolls = 4;
		c.numBlanks = 1;
		c.numInconvenient = 1;
		c.convenients = [1,2,3,4,5];
		c.numConvenient = 1;
		c.inconvenients = [2,3,4];
		
		grid = new Array2(c.width,c.height);
		
		empty = new Array();
		emptyGrid = new Array2(c.width, c.height);
		emptyGrid.walk(function(current,x,y){
			var p = new Point(x,y);
			empty.push(p);
			return p;
		});
		
		potentialScrollStarts = new Array();
	}
	
	public function generate(){
		goals = [];
		
		trace(grid);
		
		for(i in 0...c.numScrolls){
			var start:Point;
			if(potentialScrollStarts.length == 0){
				if(empty.length == 0){
					start = new Point(Random.randRange(0,c.width - 1), Random.randRange(0,c.height-1));
				}else{
					start = empty[Random.randRange(0, empty.length-1)];
				} 
			}else{
				start = potentialScrollStarts[Random.randRange(0, potentialScrollStarts.length-1)];
			}
			
			var scroll = c.scrolls[Random.randRange(0, c.scrolls.length - 1)];
			addNextScroll(start, scroll);
		}
		
		trace(grid);
		
		for(i in 0...c.numBlanks){
			var start = empty[Random.randRange(0, empty.length-1)];
			addNextScroll(start, c.zeroScroll);
		}
		
		trace(grid);
		
		for( i in 0...c.numConvenient){
			var p:Point;
			if(empty.length == 0){
				p = new Point(Random.randRange(0,c.width - 1), Random.randRange(0,c.height-1));
			}else{
				p = empty[Random.randRange(0, empty.length-1)];
			}
			setGrid()
		}
	}
	
	inline function addNextScroll(start:Point, scroll:Array<Int>){
		var dirX = Random.randRange(0,1);
		var dirY = 1 - dirX;
		
		var startD = dirX == 1 ? start.x : start.y;
			
		var randomLength = Random.randRange(2,M.min(scroll.length, c.width));

		var min = M.max(startD-randomLength+1, 0);
		var max = M.min(startD, c.width - randomLength);
		
		startD = Random.randRange(min,max);

		start.x = dirX == 1 ? startD : start.x;
		start.y = dirY == 1 ? startD : start.y; 

		if(Random.randRange(0,1) == 0){
			addScroll(start.x, start.y, dirX, dirY, scroll, randomLength);
		}else{
			addScroll(start.x, start.y, dirX, dirY, scroll, randomLength);
		}
	}
	
	inline function addScroll(startX:Int, startY:Int, dirX:Int, dirY:Int, scroll:Array<Int>, length:Int){
		var i:Int = 0;
		
		for(i in 0...length){
			setGrid(startX, startY, scroll[i]);
			addPotentialScrollStart(startX - 1, startY);
			addPotentialScrollStart(startX + 1, startY);
			addPotentialScrollStart(startX, startY - 1);
			addPotentialScrollStart(startX, startY + 1);
			startX += dirX;
			startY += dirY;
		}
	}
	
	inline function setGrid(x:Int, y:Int, value:Int){
		grid.set(x, y, value);
		removeEmpty(x, y);
	}
	
	inline function addPotentialScrollStart(x:Int, y:Int){
		if(!M.inRange(x,0,c.width-1) || !M.inRange(y,0,c.height-1)) return;
		if(emptyGrid.get(x,y) == null) return;
		potentialScrollStarts.push(emptyGrid.get(x,y));
	}
	
	inline function removeEmpty(x:Int, y:Int){
		if(!M.inRange(x,0,c.width-1) || !M.inRange(y,0,c.height-1)) return;
		if(emptyGrid.get(x,y) == null) return;
		empty.remove(emptyGrid.get(x,y));
		potentialScrollStarts.remove(emptyGrid.get(x,y));
		emptyGrid.set(x,y,null);
	}
}
