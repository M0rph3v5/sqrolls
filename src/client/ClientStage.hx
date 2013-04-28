package client;

using Imports;

class ClientStage extends Sprite{
	public function new(){
		super();
		new GameMain(this, 800, 600);
	}
}
