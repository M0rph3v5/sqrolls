
using Imports;

@:sound("assets/Sqrolls/scrolls-bgm5.mp3") class BackgroundMusic extends flash.media.Sound {}
@:sound("assets/Sqrolls/sfx-error.mp3") class SfxError extends flash.media.Sound {}
@:sound("assets/Sqrolls/sfx-goal-complete.mp3") class SfxGoalComplete extends flash.media.Sound {}
@:sound("assets/Sqrolls/sfx-level-complete.mp3") class SfxLevelComplete extends flash.media.Sound {}
@:sound("assets/Sqrolls/sfx-release-scroll.mp3") class SfxRelease extends flash.media.Sound {}
@:sound("assets/Sqrolls/sfx-take-scroll.mp3") class SfxTake extends flash.media.Sound {}
@:sound("assets/Sqrolls/sfx-unfurl-scroll.mp3") class SfxUnfurl extends flash.media.Sound {}

class SoundManager {

    public static var __instance:SoundManager;

    public static function get_instance():SoundManager
    {
        if (SoundManager.__instance == null)
            SoundManager.__instance = new SoundManager();
        return SoundManager.__instance;
    }
	
	public var bm:Sound;
	public var s_error:Sound;
	public var s_goalcomplete:Sound;
	public var s_levelcomplete:Sound;
	public var s_release:Sound;
	public var s_take:Sound;
	public var s_unfurl:Sound;
	
	public var sfxvolume = 0.6;
	
	var sfxTransform:SoundTransform;
	
	var unfurlChannel:SoundChannel;
	var goalCompleteChannel:SoundChannel;
	
	public function new () {
		bm = new BackgroundMusic();
		
		sfxTransform = new SoundTransform(sfxvolume);
		
		var transform = new SoundTransform(0.1);
		var channel = bm.play(0, 999999999, transform);
		
		s_error = new SfxError();
		s_goalcomplete = new SfxGoalComplete();
		s_levelcomplete = new SfxLevelComplete();
		s_release = new SfxRelease();
		s_take = new SfxTake();
		s_unfurl = new SfxUnfurl();
	}
	
	public function error() {
		sfxTransform.volume = 0.5;
		s_error.play(0,0,sfxTransform);
	}
	
	public function goalComplete() {
		sfxTransform.volume = 0.8;		
		goalCompleteChannel = s_goalcomplete.play(0,0,sfxTransform);
	}
	
	public function levelComplete() {
		if (goalCompleteChannel != null)
			goalCompleteChannel.stop();
		
		sfxTransform.volume = 1.0;
		s_levelcomplete.play(0,0,sfxTransform);
	}
	
	public function release() {
		sfxTransform.volume = 0.2;
		s_release.play(0,0,sfxTransform);
	}
	
	public function take() {
		sfxTransform.volume = 0.2;
		s_take.play(0,0,sfxTransform);
	}
	
	public function unfurl() {
		stopUnfurl();
		unfurlChannel = s_unfurl.play(0,0,sfxTransform);
	}
	
	public function stopUnfurl() {
		if (unfurlChannel != null)
			unfurlChannel.stop();
	}
	
}