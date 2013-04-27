#if !flash
"flash only"
#end

package client;

using Imports;

import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.Lib;

class ClientMain {
	var starling : Starling;
	
	public function new(){
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.addEventListener(Event.RESIZE, onResize);

		Lib.current.stage.color = 0x000000;
		starling = new Starling(ClientStage, Lib.current.stage);
		//starling.showStats = true;
		starling.start();
	}
	
	function onResize(e : Event) {
		var viewPortRectangle : Rectangle = new Rectangle();
		viewPortRectangle.width = Lib.current.stage.stageWidth;
		viewPortRectangle.height = Lib.current.stage.stageHeight;
		Starling.current.viewPort = viewPortRectangle;

		starling.stage.stageWidth = Lib.current.stage.stageWidth;
		starling.stage.stageHeight = Lib.current.stage.stageHeight;
	}
	
	public static function main() {
		new ClientMain();
	}
}