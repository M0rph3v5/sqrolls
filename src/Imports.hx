typedef BytesOutput = haxe.io.BytesOutput; 
typedef Signal0 = ash.signals.Signal0;
typedef Signal1<T> = ash.signals.Signal1<T>;
typedef Signal2<T1, T2> = ash.signals.Signal2<T1, T2>;
typedef BytesInput = haxe.io.BytesInput;
typedef BytesBuffer = haxe.io.BytesBuffer;
typedef Bytes = haxe.io.Bytes;
typedef MsgPack = org.msgpack.MsgPack;
typedef Timer = haxe.Timer;
typedef FrameDecoder = io.streams.FrameDecoder;
typedef FrameEncoder = io.streams.FrameEncoder;
typedef MessageEncoder = io.streams.MessageEncoder;
typedef MessageDecoder = io.streams.MessageDecoder;
typedef Stream<In, Out> = io.streams.Stream<In, Out>;
typedef ClientConnection = io.streams.ClientConnection;
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
typedef WorldMap = components.WorldMap;
typedef WorldMapS = systems.WorldMapS;
typedef Position = components.Position;
typedef PositionS = systems.PositionS;
typedef CharacterMouseControlS = systems.CharacterMouseControlS;
typedef CharacterAIRecordS = systems.CharacterAIRecordS;
typedef CharacterAIS = systems.CharacterAIS;
typedef CharacterAI = components.CharacterAI;
typedef Vec2 = nape.geom.Vec2;
typedef Animation = components.Animation;
typedef AnimationS = systems.AnimationS;
typedef Actuate = com.eclecticdesignstudio.motion.Actuate;
typedef M = de.polygonal.core.math.Mathematics;
typedef CharacterMouseControl = components.CharacterMouseControl;
typedef CharacterReplayControl = components.CharacterReplayControl;
typedef Record = components.Record;
typedef Entry = components.Record.Entry;
typedef CharacterReplayControlS = systems.CharacterReplayControlS;
typedef Action = components.CharacterAI.Action;
typedef GameManager = systems.GameManager;
typedef Space = nape.space.Space;
typedef Body = nape.phys.Body;
typedef GameState = components.GameState;
typedef Motion = components.Motion;
typedef MotionS = systems.MotionS;
typedef Flip = components.Flip;
typedef FlipS = systems.FlipS;
typedef BugAI = components.BugAI;
typedef BugAIS = systems.BugAIS;
typedef Camera = components.Camera;
typedef WorldCitizen = components.WorldCitizen;
typedef TileType = components.Tile.TileType;
typedef WorldMapCitizen = components.WorldMapCitizen;
typedef World = components.World;
typedef Tile = components.Tile;
typedef EnemyTarget = components.EnemyTarget;
typedef Health = components.Health;
typedef HealthS = systems.HealthS;
typedef WorldS = systems.WorldS;

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
#end
