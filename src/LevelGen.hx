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
	public var occupied : Array<Point>;
 	public var emptyGrid : Array2<Point>;
	public var potentialScrollStarts : Array<Point>;
	
	public var goals: Array<Array<Int>>;
	public var outGrid:Array2<Int>;
	public var scrollAmounts:Array<Int>;
	public var zeroScrollAmount:Int;

	public function new(level:Int){
		this.c = new GenConfig();
		
		switch(level){
			case 0:
				c.width = 4;
				c.height = 4;
				c.scrolls = [[1,2,3,4]];
				c.zeroScroll = [0,0,0,0];
				
				c.numScrolls = 1;
				c.numBlanks = 0;
				c.numConvenient = 1;
				c.convenients = [1];
				c.numInconvenient = 0;
				c.inconvenients = [2,3];
			case 1:
				c.width = 4;
				c.height = 4;
				c.scrolls = [[4,3,2,1]];
				c.zeroScroll = [0,0,0,0];
				
				c.numScrolls = 1;
				c.numBlanks = 0;
				c.numConvenient = 1;
				c.convenients = [1];
				c.numInconvenient = 1;
				c.inconvenients = [2,3];
			case 2:
				c.width = 4;
				c.height = 4;
				c.scrolls = [[1,2,3,4], [4,3,2,1]];
				c.zeroScroll = [0,0,0,0];
				
				c.numScrolls = 1;
				c.numBlanks = 1;
				c.numConvenient = 0;
				c.convenients = [1,2,3,4];
				c.numInconvenient = 2;
				c.inconvenients = [2,3];
			case 3:
				c.width = 4;
				c.height = 4;
				c.scrolls = [[1,2,3,4], [4,3,2,1]];
				c.zeroScroll = [0,0,0,0];
				
				c.numScrolls = 2;
				c.numBlanks = 1;
				c.numConvenient = 1;
				c.convenients = [1,2,3,4];
				c.numInconvenient = 1;
				c.inconvenients = [2,3];
			case 4:
				c.width = 4;
				c.height = 4;
				c.scrolls = [[1,2,3,4], [4,3,2,1]];
				c.zeroScroll = [0,0,0,0];
				
				c.numScrolls = 2;
				c.numBlanks = 1;
				c.numConvenient = 1;
				c.convenients = [1,2,3,4];
				c.numInconvenient = 2;
				c.inconvenients = [2,3];
			case 5 | 6:
				c.width = 4;
				c.height = 4;
				c.scrolls = [[1,2,3,4], [4,3,2,1]];
				c.zeroScroll = [0,0,0,0];
				
				c.numScrolls = 3;
				c.numBlanks = 1;
				c.numConvenient = 1;
				c.convenients = [1,2,3,4];
				c.numInconvenient = 1;
				c.inconvenients = [2,3];
			case _:
				c.width = 4;
				c.height = 4;
				c.scrolls = [[1,2,3,4], [4,3,2,1]];
				c.zeroScroll = [0,0,0,0];
				
				c.numScrolls = 4;
				c.numBlanks = 1;
				c.numConvenient = 1;
				c.convenients = [1,2,3,4];
				c.numInconvenient = 1;
				c.inconvenients = [2,3];
		}
		
		goals = new Array();
		outGrid = new Array2(c.width,c.height);
		scrollAmounts = new Array();

		grid = new Array2(c.width,c.height);
		
		empty = new Array();
		occupied = new Array();
		emptyGrid = new Array2(c.width, c.height);
		emptyGrid.walk(function(current,x,y){
			var p = new Point(x,y);
			empty.push(p);
			return p;
		});
		
		potentialScrollStarts = new Array();
	}
	
	public function generate() : Float{
		//trace(grid);
		
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

			var r = Random.randRange(0, c.scrolls.length - 1);
			var scroll = c.scrolls[r];
			trace(scroll);
			if(scroll[0] == 1) scrollAmounts[0]++;
			if(scroll[0] == 4) scrollAmounts[1]++;
			
			addNextScroll(start, scroll);
		}
		
		//trace(grid);
		
		for(i in 0...c.numBlanks){
			var start = empty[Random.randRange(0, empty.length-1)];
			addNextScroll(start, c.zeroScroll, false);
			zeroScrollAmount++;
		}
		
		//trace(grid);
		
		for( i in 0...c.numInconvenient){
			var p:Point;
			if(occupied.length == 0){
				p = new Point(Random.randRange(0,c.width - 1), Random.randRange(0,c.height-1));
			}else{
				p = occupied[Random.randRange(0, occupied.length-1)];
			}
			outGrid.set(p.x,p.y,grid.get(p.x,p.y));
		}
		
		//trace(grid);
		
		for( i in 0...c.numConvenient){
			var p:Point;
			if(empty.length == 0){
				p = new Point(Random.randRange(0,c.width - 1), Random.randRange(0,c.height-1));
			}else{
				p = empty[Random.randRange(0, empty.length-1)];
			}
			setGrid(p.x, p.y, c.convenients[Random.randRange(0,c.convenients.length-1)]);
			outGrid.set(p.x,p.y,grid.get(p.x,p.y));
		}

		//trace(grid);
		for(y in 0...c.height){
			var foundFirst:Bool = false;
			var goal:Array<Int> = null;
			for(x in 0...c.width){
				if(foundFirst && emptyGrid.get(x,y) != null){
					var moreComming:Bool = false;
					for(i in x...c.width){
						if(emptyGrid.get(i,y) == null && grid.get(i,y) != 0){
							moreComming = true;
							break;
						}
					}
					if(!moreComming){
						break;
					}
					setGrid(x, y, c.convenients[Random.randRange(0,c.convenients.length-1)]);
					outGrid.set(x,y,grid.get(x,y));
				}
				
				if(foundFirst && grid.get(x,y) == 0){
					if(goal != null && goal.length > 0) goals.push(goal);
					goal = new Array();
				}
				
				if(emptyGrid.get(x,y) == null && grid.get(x,y) != 0){
					if(!foundFirst){
						foundFirst = true;
						goal = new Array();	
					}
					
					goal.push(grid.get(x,y));
				}
			}
			if(goal != null && goal.length > 0) goals.push(goal);
		}
		
		var da = new DA<Array<Int>>();
		for(g in goals){
			da.pushBack(g);			
		}
		da.shuffle();
		goals = da.toArray();
		
		//////
		
		var score:Float = 0;
		for(goal in goals){
			if(goal.length == 1){
				score -= 1;
			}
		}
		return score;
	}
	
	inline function addNextScroll(start:Point, scroll:Array<Int>, addPotentials = true){
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
			addScroll(start.x, start.y, dirX, dirY, scroll, randomLength, addPotentials);
		}else{
			if(dirX == 1){
				addScroll(start.x + randomLength - 1, start.y, dirX * -1, dirY, scroll, randomLength, addPotentials);
			}else{
				addScroll(start.x, start.y + randomLength - 1, dirX, dirY * -1, scroll, randomLength, addPotentials);
			}
		}
	}
	
	inline function addScroll(startX:Int, startY:Int, dirX:Int, dirY:Int, scroll:Array<Int>, length:Int, addPotentials:Bool){
		var i:Int = 0;
		
		for(i in 0...length){
			setGrid(startX, startY, scroll[i]);
			if(addPotentials){
				addPotentialScrollStart(startX - 1, startY);
				addPotentialScrollStart(startX + 1, startY);
				addPotentialScrollStart(startX, startY - 1);
				addPotentialScrollStart(startX, startY + 1);
			}
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
		occupied.push(emptyGrid.get(x,y));
		potentialScrollStarts.remove(emptyGrid.get(x,y));
		emptyGrid.set(x,y,null);
	}
}
