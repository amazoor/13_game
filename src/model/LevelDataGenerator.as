package model {
	import model.vo.LevelVO;

	public class LevelDataGenerator {
		public  static function getlevelData(level:int):LevelVO {
			var levelVO:LevelVO = new LevelVO();
			
			switch (level) {
				case 1:
					levelVO.cardsLeft = 30;
					levelVO.maxPoints = 300;
					break;
				
				case 2:
					levelVO.cardsLeft = 40;
					levelVO.maxPoints = 400;
					break;
				
				case 3:
					levelVO.cardsLeft = 50;
					levelVO.maxPoints = 600;
					break;
				
				case 4:
					levelVO.cardsLeft = 60;
					levelVO.maxPoints = 900;
					break;
				
				case 5:
					levelVO.cardsLeft = 70;
					levelVO.maxPoints = 1100;
					break;
			
				case 6:
					levelVO.cardsLeft = 80;
					levelVO.maxPoints = 1500;
					break;
				
				case 7:
					levelVO.cardsLeft = 90;
					levelVO.maxPoints = 2000;
					break;
				
			}
			
			return levelVO;
		}
	}
}