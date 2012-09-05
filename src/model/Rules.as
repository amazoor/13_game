package model
{
	import view.Symbol;
	import view.symbol.Colors;
	import view.symbol.Fill;
	
	public class Rules
	{
		
		public static function checkRule(level:uint, symbol:Symbol):Boolean {
			switch (level) {
				case 1:
					if ((symbol.figureColor == Colors.BLUE || symbol.figureColor == Colors.GREEN || symbol.figureColor == Colors.RED) &&
						(symbol.fill == Fill.BORDER || symbol.fill == Fill.FILL || symbol.fill == Fill.GRADIENT))
						return true;
					break;
				
				case 1:
					break;
				
				case 1:
					break;
				
				case 1:
					break;
				
				case 1:
					break;
				
				case 1:
					break;
				
				case 1:
					break;
			}
			
			return false;
		}
		
	}
}