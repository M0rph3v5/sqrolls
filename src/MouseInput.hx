package;

using Imports;

import flash.display.Stage;

class MouseInput {
	public var onClick:Signal1<Vec2>;
	public var onRightClick:Signal1<Vec2>;
	
	public function new(stage:Stage){
		onClick = new Signal1<Vec2>();
		onRightClick = new Signal1<Vec2>();
		
		stage.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){
			onClick.dispatch(new Vec2(e.stageX, e.stageY));			
		});
		stage.addEventListener(MouseEvent.RIGHT_CLICK, function(e:MouseEvent){
			onRightClick.dispatch(new Vec2(e.stageX, e.stageY));
		});		
	}
}
