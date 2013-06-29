package levels
{
	public class LevelQueue
	{
		private var levelQueue:Vector.<String>;
		private var currentLevel:int = 0;
		
		public function LevelQueue()
		{
			levelQueue = new Vector.<String>();
			levelQueue.push("asciiLevel1");
			levelQueue.push("asciiLevel2");
		}
		
		public function getNextLevel():Level{
			return new GeneratedLevel(levelQueue[currentLevel++]);
		}
	}
}