#if !flash
"flash only"
#end

package graphics;

using Imports;

@:bitmap("assets/Assets.png") class Assets extends BitmapData{public function new(){super(1024, 1024);}}
@:file("assets/Assets.xml") class AssetsXml extends ByteArray{}
class Graphics {
	var texture:Texture;
	var xml:XML;
	var textureAtlas : TextureAtlas;
	
	public function new(){
		texture = Texture.fromBitmapData(new Assets());
		var assetsXml = new AssetsXml();
		xml = new XML(assetsXml.readUTFBytes(assetsXml.length));
		textureAtlas = new TextureAtlas(texture, xml);
	}
	
	public function getTexture(id:String):Texture{
		return textureAtlas.getTexture(id);
	}
}

