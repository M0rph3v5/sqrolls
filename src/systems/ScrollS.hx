package systems;
using Imports;

class ScrollN extends Node<ScrollN>{
	public var scroll:Scroll;
	public var transform:Transform;
	public var coord:Coord;
	public var gameCitizen:GameCitizen;
}

class ScrollS extends ListIteratingSystem<ScrollN>{
	var mouseInput:MouseInput;
	var creator:EntityCreator;
	var engine:Engine;
	var scrollList:NodeList<ScrollN>;
	var activeScrollNode:ScrollN;
	
	var moved:Bool = false;
	var lastCoords = null;
	
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
		if (!node.scroll.dragging && !node.scroll.justAdded)
			return;
		
		// create tile items for everything in between begin & endpoint
		// figure out coords you need to take				
		var xd = -Std.int(node.scroll.beginPoint.x - node.scroll.endPoint.x);
		var yd = -Std.int(node.scroll.beginPoint.y - node.scroll.endPoint.y);

		var xb = Math.abs(xd) > Math.abs(yd);
		var increment = xb ? new Vec2(xd, 0) : new Vec2(0, yd);
		if (increment.length > 0)
			increment.length = 1;
		
		var xdistance = Math.min(Math.abs(xd),4);
		var ydistance = Math.min(Math.abs(yd),4);
		var coords = ray(node.scroll.beginPoint, increment, xb ? Std.int(xdistance) : Std.int(ydistance) );
		
		if (lastCoords != null && coords.toString() == lastCoords.toString()) {
			return;
		}

		// keep track of tile items on scroll node
		for (e in node.scroll.tileItems) {
			engine.removeEntity(e);
		}
		
		node.scroll.tileItems.splice(0, node.scroll.tileItems.length);
		
		// create new tileitems for the ones missing
		var index = 0;
		//var lastIndex = coords.length-1;
		for (coord in coords) {
			for (t in node.scroll.grid.tiles.get(Std.int(coord.x), Std.int(coord.y))) {
				if (!t.has(Tile))
					continue;
				var tileItem = creator.createTileItem(node.gameCitizen.game, node.scroll.grid, t.get(Tile), node.scroll.data[index], coord);
				node.scroll.tileItems.push(tileItem);
			}
			index++;
		}
		lastCoords = coords;
		
		SoundManager.get_instance().unfurl();
		
		node.scroll.justAdded = false;
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
		activeScrollNode.scroll.justAdded = true;		
	}
	
	function remove(node:ScrollN){
		for (tileEntity in node.scroll.tileItems) {
			engine.removeEntity(tileEntity);
		}
	}

	function onMouseDown(pos:Vec2) {
		
	}
	
	function onMouseUp(pos:Vec2) {
		SoundManager.get_instance().stopUnfurl();
		
		if (!moved) { // intended to remove / pickup a scroll
			var nodeToRemove = null;
			
			// check scroll at position
			for (node in scrollList) {
				var coord = Utils.coordForPosition(pos, node.scroll.grid);
				if (coord == null)
					break;
				
				// check if scroll has tileitems at that coord
				for (tileEntity in node.scroll.tileItems) {
					var gridCitizen = tileEntity.get(GridCitizen);
					if (Vec2.distance(coord, gridCitizen.pos) != 0)
						continue;
					
					var tileCitizen = tileEntity.get(TileCitizen);
					var stack : Array<Entity> = tileCitizen.tile.stack;
					if(stack[stack.length-1] == tileEntity) {
						nodeToRemove = node;
						break;
					}
				}
				
				if (nodeToRemove != null) {
					break;
				}
			}
			
			if (nodeToRemove != null) {	
				nodeToRemove.gameCitizen.game.refund = nodeToRemove.scroll.data[0];
				engine.removeEntity(nodeToRemove.entity);
			}
			
		}
		
		if (activeScrollNode != null) {
			activeScrollNode.scroll.dragging = false;
			
			if (moved) {
				activeScrollNode.gameCitizen.game.activeScrollInventoryItem = null;
				SoundManager.get_instance().release();
			}			
		}
		
		moved = false;
		lastCoords = null;
	}
	
	function onMouseMove(pos:Vec2, mouseDown:Bool) {
		if (activeScrollNode == null || !activeScrollNode.scroll.dragging) {
			return;
		}
			
		moved = true;
		
		var targetEndPoint = Utils.coordForPosition(pos, activeScrollNode.scroll.grid);
		if (targetEndPoint != null) {
			activeScrollNode.scroll.endPoint = targetEndPoint;
		}
			
		if(Math.abs(activeScrollNode.scroll.endPoint.x - activeScrollNode.scroll.beginPoint.x) < Math.abs(activeScrollNode.scroll.endPoint.y - activeScrollNode.scroll.beginPoint.y)){
			activeScrollNode.scroll.endPoint.x = activeScrollNode.scroll.beginPoint.x;
		}else{
			activeScrollNode.scroll.endPoint.y = activeScrollNode.scroll.beginPoint.y;
		}
	}
}
