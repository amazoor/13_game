package model
{
	import flash.utils.Dictionary;
	
	import view.Symbol;
	import view.symbol.BGAlphaStyle;
	import view.symbol.BorderStyle;
	import view.symbol.Colors;
	import view.symbol.FIgures;
	import view.symbol.Fill;
	
	public class Rules
	{
		public  var bgColor:uint;
		public  var bgImageAlpah:String;
		public  var borderStyle:String;
		public  var figure:String;
		public  var figureColor:uint;
		public  var fill:String;
		public  var figuresAmount:uint;
		
		public  const RULE_1:Array = ["figureColor", "fill"];
		public  const RULE_2:Array = ["figureColor", "fill", "figure"];
		public  const RULE_3:Array = ["figureColor", "fill", "figure", "borderStyle"];
		public  const RULE_4:Array = ["figureColor", "fill", "figure", "figuresAmount"];
		public  const RULE_5:Array = ["figureColor", "fill", "figure", "figuresAmount", "borderStyle"];
		public  const RULE_6:Array = ["bgImageAlpah", "borderStyle", "figure", "figureColor", "fill", "figuresAmount"];
		public  const RULE_7:Array = ["bgColor", "bgImageAlpah", "borderStyle", "figure", "figureColor", "fill", "figuresAmount"];
		
		public  const BG_COLORS:Array = [Colors.WHITE, Colors.GREY, Colors.BIEGE];
		public  const BG_IMAGE_ALPHAS:Array = [ BGAlphaStyle.DIAGONAL_LINES, BGAlphaStyle.HORIZONTAL_LINES, BGAlphaStyle.VERTICAL_LINES ];
		public  const BORDER_STYLES:Array = [BorderStyle.DASHED, BorderStyle.DOTS, BorderStyle.SOLID];
		public  const FIGURES:Array = [ FIgures.CIRCLE, FIgures.TRIANGLE, FIgures.SQUARE];
		public  const FIGURE_COLORS:Array = [Colors.BLUE, Colors.GREEN, Colors.RED];
		public  const FILL:Array = [Fill.BORDER, Fill.FILL, Fill.GRADIENT];
		public  const FIGURES_AMOUNT:Array = [1, 2, 3];
		
		public  var dict:Dictionary = new Dictionary();
		public  var rule:String;
		
		public  function generateRule(level:uint):void {
			rule = this["RULE_"+level][Math.floor(Math.random() * RULE_1.length)];
			
			switch (rule) {
				case "figureColor":
					dict[rule] = FIGURE_COLORS[Math.floor(Math.random() * FIGURE_COLORS.length)];
					break;
				case "fill":
					dict[rule] = FILL[Math.floor(Math.random() * FILL.length)];
					break;
				case "figure":
					dict[rule] = FIGURES[Math.floor(Math.random() * FIGURES.length)];
					break;
				case "bgColor":
					dict[rule] = BG_COLORS[Math.floor(Math.random() * BG_COLORS.length)];
					break;
				case "bgImageAlpah":
					dict[rule] = BG_IMAGE_ALPHAS[Math.floor(Math.random() * BG_IMAGE_ALPHAS.length)];
					break;
				case "borderStyle":
					dict[rule] = BORDER_STYLES[Math.floor(Math.random() * BORDER_STYLES.length)];
					break;
				
				case "figuresAmount":
					dict[rule] = FIGURES_AMOUNT[Math.floor(Math.random() * FIGURES_AMOUNT.length)];
					break;
			}
			
			trace(rule, dict[rule]);
			
		}
		
		public  function checkRule(symbol:Symbol):Boolean {
			return symbol[rule] == dict[rule] ? true : false
		}
		
	}
}