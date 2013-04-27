typedef BytesOutput = haxe.io.BytesOutput; 
typedef Signal0 = ash.signals.Signal0;
typedef Signal1<T> = ash.signals.Signal1<T>;
typedef Signal2<T1, T2> = ash.signals.Signal2<T1, T2>;
typedef BytesInput = haxe.io.BytesInput;
typedef BytesBuffer = haxe.io.BytesBuffer;
typedef Bytes = haxe.io.Bytes;
typedef Timer = haxe.Timer;
typedef Engine = ash.core.Engine;
typedef System = ash.core.System;
typedef NodeList<T:Node<T>> = ash.core.NodeList<T>;
typedef Entity = ash.core.Entity;
typedef ListIteratingSystem<T:Node<T>> = ash.tools.ListIteratingSystem<T>;
typedef Node<T> = ash.core.Node<T>;
typedef Mat23 = nape.geom.Mat23;
typedef Transform = components.Transform;
typedef IAnimatable = starling.animation.IAnimatable;
typedef Array3<T> = de.polygonal.ds.Array3<T>;
typedef Vec2 = nape.geom.Vec2;
typedef Actuate = com.eclecticdesignstudio.motion.Actuate;
typedef M = de.polygonal.core.math.Mathematics;
typedef Space = nape.space.Space;
typedef Body = nape.phys.Body;

typedef GridS = systems.GridS;
typedef Grid = components.Grid;
typedef Array2<T> = de.polygonal.ds.Array2<T>;
typedef Random = de.polygonal.core.math.random.Random;
typedef Tile = components.Tile;
typedef GridRenderS = systems.GridRenderS;
typedef TileItem = components.TileItem;

#if flash
typedef Socket = flash.net.Socket;
typedef Event = flash.events.Event;
typedef ProgressEvent = flash.events.ProgressEvent;
typedef IOErrorEvent = flash.events.IOErrorEvent;
typedef SecurityErrorEvent = flash.events.SecurityErrorEvent;
typedef EventDispatcher = flash.events.EventDispatcher;
typedef ByteArray = flash.utils.ByteArray;
typedef Starling = starling.core.Starling;
typedef Sprite = starling.display.Sprite;
typedef Quad = starling.display.Quad;
typedef Color = starling.utils.Color;
typedef DisplayObject = starling.display.DisplayObject;
typedef RenderS = systems.RenderS;
typedef Display = components.Display;
typedef DisplayObjectContainer = starling.display.DisplayObjectContainer;
typedef Graphics = graphics.Graphics;
typedef Texture = starling.textures.Texture;
typedef BitmapData = flash.display.BitmapData;
typedef Bitmap = flash.display.Bitmap;
typedef XML = flash.xml.XML;
typedef TextureAtlas = starling.textures.TextureAtlas;
typedef Image = starling.display.Image;
typedef MouseEvent = flash.events.MouseEvent;
typedef KeyboardEvent = flash.events.KeyboardEvent;
typedef Keyboard = flash.ui.Keyboard;
typedef TextField = starling.text.TextField;
#end