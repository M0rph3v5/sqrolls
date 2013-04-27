package systems;
using Imports;

class ScrollN extends Node<ScrollN>{
	public var scroll:Scroll;
	public var transform:Transform;
	public var coord:Coord;
}

class ScrollS extends ListIteratingSystem<ScrollN>{
	var mouseInput:MouseInput;
	var creator:EntityCreator;
	var scrollList:NodeList<ScrollN>;
	var activeScrollNode:ScrollN;
	
	public function new(creator:EntityCreator, mouseInput:MouseInput){
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
		
		if (!node.scroll.dragging)
			return;
		
		// create tile items for everything in between begin & endpoint
		// figure out coords you need to take				
		var xd = -Std.int(node.scroll.beginPoint.x - node.scroll.endPoint.x);
		var yd = -Std.int(node.scroll.beginPoint.y - node.scroll.endPoint.y);
		if (xd == yd)
			return;
		
		var xb = Math.abs(xd) > Math.abs(yd);
		var increment = xb ? new Vec2(xd, 0) : new Vec2(0, yd);
		if (increment.length > 0)
			increment.length = 1;
		var coords = ray(node.scroll.beginPoint, increment, xb ? Std.int(Math.abs(xd)) : Std.int(Math.abs(yd)));
				
		// keep track of tile items on scroll node
		
		// create new tileitems for the ones missing
		
		// remove ones that are not needed anymore
		
	}
	
	function ray(start:Vec2, increment:Vec2, length:Int) {
		//trace("start point " + start + " increment " + increment + " length " + length);
		
		var currentPosition = start.copy();
		var positions = new Array();
		
		for (i in 0...length) {
			currentPosition.x += increment.x;
			currentPosition.y += increment.y;
			
			positions.push(currentPosition.copy());			
		}
		
		return positions;
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
		
		activeScrollNode.scroll.endPoint = Utils.coordForPosition(pos);
	}
	
}
