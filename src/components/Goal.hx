package components;

using Imports;

class Goal {
	public var goal:Array<Int>;
	public var achieved:Bool = false;
	
	public function new(goal:Array<Int>){
		this.goal = goal;
	}
}
