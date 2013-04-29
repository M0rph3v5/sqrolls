package systems;

using Imports;

class GameCitizenN extends Node<GameCitizenN>{
	public var gameCitizen:GameCitizen;
}

class GameN extends Node<GameN>{
	public var game:Game;
}

class GameCitizenS extends System{
	var engine:Engine;
	var gameCitizens:NodeList<GameCitizenN>;
	
	public function new(){
		super();
	}
	
	override public function addToEngine(engine:Engine){
		super.addToEngine(engine);
		this.engine = engine;
		engine.getNodeList(GameN).nodeRemoved.add(gameNodeRemoved);
		gameCitizens = engine.getNodeList(GameCitizenN);
	}
	
	function gameNodeRemoved(gameNode:GameN){
		for(node in gameCitizens){
			if(gameNode.game == node.gameCitizen.game){
				engine.removeEntity(node.entity);
			}
		}
	}
}
