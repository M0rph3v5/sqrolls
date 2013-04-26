package systems;

using Imports;

class RenderN extends Node<RenderN>{
	public var display:Display;
	public var transform:Transform;
}

class RenderS extends ListIteratingSystem<RenderN>{
	
	var container:DisplayObjectContainer;
	var list:NodeList<RenderN>;
	
	public function new(container:DisplayObjectContainer){
		super(RenderN, updateN, add, remove);
		this.container = container;
	}
	
	override public function addToEngine(engine:Engine){
		super.addToEngine(engine);
		list = engine.getNodeList(RenderN);
	}
	
	var depth:Int = 0;
	override public function update(time:Float){
		depth = 0;
		
		list.insertionSort(function(node1:RenderN, node2:RenderN):Int{
			return node1.display.depth - node2.display.depth < 0 ? -1 : 1;
		});
		super.update(time);
	}
	
	function add(node:RenderN){
		container.addChild(node.display.displayObject);
	}
	
	function remove(node:RenderN){
		container.removeChild(node.display.displayObject);
	}
	
	function updateN(node:RenderN, time:Float){
		node.display.offset.concat(node.transform.transform).toMatrix(node.display.displayObject.transformationMatrix);
		container.setChildIndex(node.display.displayObject, depth++);
	}
}