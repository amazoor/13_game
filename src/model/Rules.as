package model {
	import flash.sampler.NewObjectSample;
	import flash.utils.Dictionary;
	
	import view.Symbol;
	import view.symbol.BGAlphaStyle;
	import view.symbol.BorderStyle;
	import view.symbol.Colors;
	import view.symbol.FIgures;
	import view.symbol.Fill;
	
	public class Rules {
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
		
		
		
		public  const FIGURES:Array				= [ FIgures.CIRCLE, FIgures.TRIANGLE, FIgures.SQUARE];
		public  const FIGURE_COLORS:Array 		= [Colors.BLUE, Colors.GREEN, Colors.RED];
		public  const FILL:Array 				= [Fill.BORDER, Fill.FILL, Fill.GRADIENT];
		
		public  const BG_IMAGE_ALPHAS:Array		= [BGAlphaStyle.NO_LINES, BGAlphaStyle.DIAGONAL_LINES, BGAlphaStyle.HORIZONTAL_LINES];
		public  const BORDER_STYLES:Array 		= [BorderStyle.SOLID, BorderStyle.DASHED, BorderStyle.DOTS];
		public  const BG_COLORS:Array 			= [Colors.WHITE, Colors.GREY, Colors.BIEGE];
		public  const FIGURES_AMOUNT:Array 		= [1, 2, 3];
		
		private  var _dict:Dictionary = new Dictionary();
		private  var _rule:String;
		
		public function get dict():Dictionary {
			return _dict;
		}
		
		public function set dict(value:Dictionary):void {
			_dict = value;
		}
		private var _currentRule:Dictionary;
		
		public  function generateRule(level:uint):Dictionary {
			
			_rule = this["RULE_"+level][Math.floor(Math.random() * this["RULE_"+level].length)];
			
			dict = new Dictionary();
			
			trace(_rule)
			
			dict = getRule(_rule);
			
			while (_currentRule == dict)
				dict = getRule(_rule);
			_currentRule = dict;
			/*switch (_rule) {
				case "figureColor":		dict[_rule] = FIGURE_COLORS[Math.floor(Math.random() * FIGURE_COLORS.length)];		break;
				case "fill":			dict[_rule] = FILL[Math.floor(Math.random() * FILL.length)];						break;
				case "figure":			dict[_rule] = FIGURES[Math.floor(Math.random() * FIGURES.length)];					break;
				case "bgColor":			dict[_rule] = BG_COLORS[Math.floor(Math.random() * BG_COLORS.length)];				break;
				case "bgImageAlpah":	dict[_rule] = BG_IMAGE_ALPHAS[Math.floor(Math.random() * BG_IMAGE_ALPHAS.length)];	break;
				case "borderStyle":		dict[_rule] = BORDER_STYLES[Math.floor(Math.random() * BORDER_STYLES.length)];		break;
				case "figuresAmount":	dict[_rule] = FIGURES_AMOUNT[Math.floor(Math.random() * FIGURES_AMOUNT.length)];	break;
			}
				*/		
			return dict;
		}
		
		private function getRule(rule:String):Dictionary {
			var d:Dictionary = new Dictionary();
			switch (_rule) {
				case "figureColor":		d[_rule] = FIGURE_COLORS[Math.floor(Math.random() * FIGURE_COLORS.length)];		break;
				case "fill":			d[_rule] = FILL[Math.floor(Math.random() * FILL.length)];						break;
				case "figure":			d[_rule] = FIGURES[Math.floor(Math.random() * FIGURES.length)];					break;
				case "bgColor":			d[_rule] = BG_COLORS[Math.floor(Math.random() * BG_COLORS.length)];				break;
				case "bgImageAlpah":	d[_rule] = BG_IMAGE_ALPHAS[Math.floor(Math.random() * BG_IMAGE_ALPHAS.length)];	break;
				case "borderStyle":		d[_rule] = BORDER_STYLES[Math.floor(Math.random() * BORDER_STYLES.length)];		break;
				case "figuresAmount":	d[_rule] = FIGURES_AMOUNT[Math.floor(Math.random() * FIGURES_AMOUNT.length)];	break;
			}
			return d;
		}
		
		public  function checkRule(symbol:Symbol):Boolean {
			return symbol[_rule] == dict[_rule] ? true : false
		}
	}
}