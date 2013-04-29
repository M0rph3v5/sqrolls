package systems;

using Imports;

class NextLevelButtonN extends Node<NextLevelButtonN>{
	public var button:Button;
}

class NextLevelButtonS extends ListIteratingSystem<NextLevelButtonN>{
	public function new(){
		super(NextLevelButtonN, updateN);
	}
	
	function updateN(node:NextLevelButtonN, time:Float){
		
	}
}
