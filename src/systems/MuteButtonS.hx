package systems;

using Imports;

class MuteButtonN extends Node<MuteButtonN>{
	public var gameCitizen:GameCitizen;
	public var button:Button;
	public var muteButton:MuteButton;
}

class MuteButtonS extends ListIteratingSystem<MuteButtonN>{
	var graphics:Graphics;
	
	public function new(graphics:Graphics){
		super(MuteButtonN, updateN, add, remove);
		this.graphics = graphics;
	}
	
	function add(node:MuteButtonN){
		node.muteButton.enabled = new Image(graphics.getTexture("button-mute"));
		node.muteButton.disabled = new Image(graphics.getTexture("button-mute-enabled"));
		
		node.muteButton.dpo.addChild(node.muteButton.enabled);
		node.muteButton.dpo.addChild(node.muteButton.disabled);
	}
	
	function remove(node:MuteButtonN){
		
	}
	
	function updateN(node:MuteButtonN, time:Float){
		
		var currentMuteState = SoundManager.get_instance().mute;
		node.muteButton.enabled.visible = !currentMuteState;
		node.muteButton.disabled.visible = currentMuteState;
		
		node.muteButton.enabled.color = 0xffffff;
		node.muteButton.disabled.color = 0xffffff;
		if(node.button.mouseOver){
			node.muteButton.enabled.color = 0xc0c0c0;
			node.muteButton.disabled.color = 0xc0c0c0;
		}
		
		if(node.button.down){
			node.muteButton.enabled.color = 0;
			node.muteButton.disabled.color = 0;
		}

		if (node.button.pressed) {
			SoundManager.get_instance().mute = !currentMuteState;					
		}
	}
}
