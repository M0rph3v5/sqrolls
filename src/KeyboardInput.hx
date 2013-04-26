package;

using Imports;

import flash.display.Stage;

class KeyboardInput {
	public var onKeyDown:Signal1<Int>;
	public var onKeyUp:Signal1<Int>;
	
	var stage:Stage;
	var states:Bytes;
	
	public function new(stage:Stage){
		onKeyDown = new Signal1<Int>();
		onKeyUp = new Signal1<Int>();
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent){
		});
		stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent){
		});
		
		states = Bytes.alloc(8);
        this.stage = stage;

        stage.addEventListener(KeyboardEvent.KEY_DOWN, function(ev){
			var pos:Int = ev.keyCode >>> 3;
     		states.set(pos, states.get(pos) | 1 << (ev.keyCode & 7));
			onKeyDown.dispatch(ev.keyCode);
		});
        stage.addEventListener(KeyboardEvent.KEY_UP, function(ev){
			var pos:Int = ev.keyCode >>> 3;
        	states.set(pos, states.get(pos) & ~(1 << (ev.keyCode & 7)));
			onKeyUp.dispatch(ev.keyCode);
		});
        stage.addEventListener(Event.ACTIVATE, function(ev){
			for (i in 0...8){
            	states.set(i, 0);
			}
		});
        stage.addEventListener(Event.DEACTIVATE, function(ev){
			for (i in 0...8)
            	states.set(i, 0);
		});
	}
	
    public function isDown(keyCode:Int):Bool
    {
        return ( states.get(keyCode >>> 3) & (1 << (keyCode & 7)) ) != 0;
    }

    public function isUp(keyCode:Int):Bool
    {
        return ( states.get(keyCode >>> 3) & (1 << (keyCode & 7)) ) == 0;
    }
}
