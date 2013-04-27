package systems;
using Imports;

class ScrollN extends Node<ScrollN>{
	public var scroll:Scroll;
	public var transform:Transform;
	public var coord:Coord;
}

class ScrollS extends ListIteratingSystem<ScrollN>{
	var mouseInput:MouseInput;
	var scrollList:NodeList<ScrollN>;
	var activeScrollNode:ScrollN;
	
	public function new(mouseInput:MouseInput){
		super(ScrollN, updateN, add, remove);
		
		this.mouseInput = mouseInput;		
		this.mouseInput.onMouseDown.add(onMouseDown);
		this.mouseInput.onMouseUp.add(onMouseUp);
		this.mouseInput.onMouseMove.add(onMouseMove);		
	}	
			
	override public function addToEngine(engine:Engine){
		super.addToEngine(engine);
		scrollList = engine.getNodeList(ScrollN);		
	}
		
	function updateN(node:ScrollN, time:Float){
		// do update rendering of the scroll?
	}
	
	function add(node:ScrollN){
		activeScrollNode = node;
		activeScrollNode.scroll.dragging = true;
	}
	
	function remove(node:ScrollN){
		
	}
			
	function onMouseDown(pos:Vec2) {
		
	}
	
	function onMouseUp(pos:Vec2) {
		activeScrollNode.scroll.dragging = false;
	}
	
	function onMouseMove(pos:Vec2) {
		if (activeScrollNode == null || !activeScrollNode.scroll.dragging)
			return;
		
		activeScrollNode.coord.coord = Utils.coordForPosition(pos);
	}
	
}
