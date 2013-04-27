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
	var engine:Engine;
	var scrollList:NodeList<ScrollN>;
	var activeScrollNode:ScrollN;
	
	public function new(creator:EntityCreator, mouseInput:MouseInput){
		super(ScrollN, updateN, add, remove);
		
		this.mouseInput = mouseInput;		
		this.mouseInput.onMouseDown.add(onMouseDown);
		this.mouseInput.onMouseUp.add(onMouseUp);
		this.mouseInput.onMouseMove.add(onMouseMove);		
		
		this.creator = creator;
	}	
			
	override public function addToEngine(engine:Engine){
		super.addToEngine(engine);
		scrollList = engine.getNodeList(ScrollN);		
		this.engine = engine;
	}
		
	function updateN(node:ScrollN, time:Float){
		
		if (!node.scroll.dragging)
			return;
		
		// create tile items for everything in between begin & endpoint
		// figure out coords you need to take				
		var xd = -Std.int(node.scroll.beginPoint.x - node.scroll.endPoint.x);
		var yd = -Std.int(node.scroll.beginPoint.y - node.scroll.endPoint.y);
		//trace("xd " + xd + " yd " + yd);

		var xb = Math.abs(xd) > Math.abs(yd);
		var increment = xb ? new Vec2(xd, 0) : new Vec2(0, yd);
		if (increment.length > 0)
			increment.length = 1;
		var coords = ray(node.scroll.beginPoint, increment, xb ? Std.int(Math.abs(xd)) : Std.int(Math.abs(yd)));

		// keep track of tile items on scroll node
		for (e in node.scroll.tileItems) {
			engine.removeEntity(e);
		}
		
		node.scroll.tileItems.splice(0, node.scroll.tileItems.length);
		
		// create new tileitems for the ones missing
		var index = 0;
		for (coord in coords) {
			for (t in node.scroll.grid.tiles.get(Std.int(coord.x), Std.int(coord.y))) {
				if (!t.has(Tile))
					continue;
				
				var tileItem = creator.createTileItem(node.scroll.grid, t.get(Tile), node.scroll.data[index], coord);
				node.scroll.tileItems.push(tileItem);
			}
			index++;
		}
		
	}
	
	function ray(start:Vec2, increment:Vec2, length:Int) {
		//trace("start point " + start + " increment " + increment + " length " + length);
		
		var currentPosition = start.copy();
		var positions = new Array();
		positions.push(start.copy());
		
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
		if (activeScrollNode == null)
			return;
		
		activeScrollNode.scroll.dragging = false;
	}
	
	function onMouseMove(pos:Vec2) {
		if (activeScrollNode == null || !activeScrollNode.scroll.dragging)
			return;
		
		var targetEndPoint = Utils.coordForPosition(pos, activeScrollNode.scroll.grid);
		if (targetEndPoint != null)
			activeScrollNode.scroll.endPoint = targetEndPoint;
		if(Math.abs(activeScrollNode.scroll.endPoint.x - activeScrollNode.scroll.beginPoint.x) < Math.abs(activeScrollNode.scroll.endPoint.y - activeScrollNode.scroll.beginPoint.y)){
			activeScrollNode.scroll.endPoint.x = activeScrollNode.scroll.beginPoint.x;
		}else{
			activeScrollNode.scroll.endPoint.y = activeScrollNode.scroll.beginPoint.y;
		}
	}
}
