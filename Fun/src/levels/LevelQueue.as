package levels
{
	import game.Player;

	public class LevelQueue
	{
		private var levelQueue:Vector.<String>;
		private var currentLevel:int = 0;
		
		public function LevelQueue()
		{
			levelQueue = new Vector.<String>();
			//levelQueue.push(AsciiLevels.asciiLevel0);
			levelQueue.push(AsciiLevels.asciiLevel1);
			levelQueue.push(AsciiLevels.asciiLevel2);
			levelQueue.push(AsciiLevels.asciiLevel3);
			
			// last level
			levelQueue.push(AsciiLevels.GameWin);
		}
		
		public function getNextLevel(player:Player):Level{
			return new GeneratedLevel(levelQueue[currentLevel++], player);
		}
	}
}
