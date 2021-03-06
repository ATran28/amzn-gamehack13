package levels
{
	import game.Player;
	
	import starling.utils.AssetManager;

	public class LevelQueue
	{
		private var levelQueue:Vector.<String>;
		private var currentLevel:int = 0;
		
		public function LevelQueue()
		{
			levelQueue = new Vector.<String>();
			levelQueue.push(AsciiLevels.asciiLevel0);
			levelQueue.push(AsciiLevels.asciiLevel1);
			levelQueue.push(AsciiLevels.owenLevel1);
			levelQueue.push(AsciiLevels.asciiLevel2);
			levelQueue.push(AsciiLevels.asciiLevel4);
			levelQueue.push(AsciiLevels.asciiLevel37);
			levelQueue.push(AsciiLevels.asciiLevel38); 
			levelQueue.push(AsciiLevels.asciiLevel39); 
			levelQueue.push(AsciiLevels.asciiLevel40);
			levelQueue.push(AsciiLevels.asciiLevel41); 
			levelQueue.push(AsciiLevels.asciiLevel42);
			levelQueue.push(AsciiLevels.backAndForth); 
			levelQueue.push(AsciiLevels.upUpUp); 
			levelQueue.push(AsciiLevels.asciiDeathPit);
			levelQueue.push(AsciiLevels.crazy);
			
			// last level
			levelQueue.push(AsciiLevels.GameWin);
		}
		public function renewCurrentLevel(player:Player):Level {
			return new GeneratedLevel(levelQueue[currentLevel-1], player);
		}
		public function getNextLevel(player:Player):Level{
			return new GeneratedLevel(levelQueue[currentLevel++], player);
		}
	}
}
