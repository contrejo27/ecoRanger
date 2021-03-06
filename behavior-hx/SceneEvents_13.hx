package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class SceneEvents_13 extends SceneScript
{
	public var _dozerMetal:Float;
	public var _dozerGlass:Float;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("dozerMetal", "_dozerMetal");
		_dozerMetal = 0.0;
		nameMap.set("dozerGlass", "_dozerGlass");
		_dozerGlass = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		if(((Engine.engine.getGameAttribute("gameCubeMetal") >= 50) && (Engine.engine.getGameAttribute("gameCubeGlass") >= 50)))
		{
			getActor(1).setAnimation("" + "Animation 0");
		}
		else
		{
			getActor(1).setAnimation("" + "Animation 1");
		}
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(getActor(1), function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 3 == mouseState)
			{
				if((getActor(1).getAnimation() == "Animation 0"))
				{
					Engine.engine.setGameAttribute("gameCubeGlass", (Engine.engine.getGameAttribute("gameCubeGlass") - 50));
					Engine.engine.setGameAttribute("gameCubeMetal", (Engine.engine.getGameAttribute("gameCubeMetal") - 50));
					Engine.engine.setGameAttribute("dozerStrength", (Engine.engine.getGameAttribute("dozerStrength") + 1));
					saveGame("mySave", function(success:Bool):Void
					{
						if(success)
						{
							switchScene(GameModel.get().scenes.get(14).getID(), null, createCrossfadeTransition(0.3));
						}
						else
						{
							
						}
					});
				}
			}
		});
		
		/* ============================ Swipe ============================= */
		addSwipeListener(function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && Input.swipedRight)
			{
				switchScene(GameModel.get().scenes.get(8).getID(), null, createCrossfadeTransition(0));
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}