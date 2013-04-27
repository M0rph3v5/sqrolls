package;

using Imports;

import flash.display.Stage;

class MouseInput {
	public var onClick:Signal1<Vec2>;
	public var onRightClick:Signal1<Vec2>;
	public var onMouseDown:Signal1<Vec2>;
	public var onMouseUp:Signal1<Vec2>;
	public var onMouseMove:Signal1<Vec2>;
	
	public function new(stage:Stage){
		onClick = new Signal1<Vec2>();
		onRightClick = new Signal1<Vec2>();
		onMouseDown = new Signal1<Vec2>();
		onMouseUp = new Signal1<Vec2>();
		onMouseMove = new Signal1<Vec2>();
		
		stage.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){
			onClick.dispatch(new Vec2(e.stageX, e.stageY));			
		});
		stage.addEventListener(MouseEvent.RIGHT_CLICK, function(e:MouseEvent){
			onRightClick.dispatch(new Vec2(e.stageX, e.stageY));
		});		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) {
			onMouseDown.dispatch(new Vec2(e.stageX, e.stageY));
		});
		stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent) {
			onMouseUp.dispatch(new Vec2(e.stageX, e.stageY));
		});
		stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e:MouseEvent) {
			onMouseMove.dispatch(new Vec2(e.stageX, e.stageY));
		});
	}
}
