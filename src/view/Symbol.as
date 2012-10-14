package view {
	import events.ImageEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.Security;
	
	import utils.ImageUtils;
	
	import view.symbol.BGAlphaStyle;
	import view.symbol.BorderStyle;
	import view.symbol.Colors;
	import view.symbol.FIgures;
	import view.symbol.Fill;
	
	import vo.SymbolVO;
	
	public class Symbol extends Sprite {
		private static const WIDTH	:uint = 155;
		private static const HEIGHT	:uint = 155;
		
		private var _container:Sprite = new Sprite();
		
		public var bgColor:uint;
		public var bgImageAlpah:String;
		public var borderStyle:String;
		public var figure:String;
		public var figureColor:uint;
		public var fill:String;
		public var figuresAmount:uint;
		
		public static const BG_COLORS:Array = [Colors.WHITE, Colors.GREY, Colors.BIEGE];
		public static const BG_IMAGE_ALPHAS:Array = [ BGAlphaStyle.DIAGONAL_LINES, BGAlphaStyle.HORIZONTAL_LINES, BGAlphaStyle.NO_LINES ];
		public static const BORDER_STYLES:Array = [BorderStyle.DASHED, BorderStyle.DOTS, BorderStyle.SOLID];
		public static const FIGURES:Array = [ FIgures.CIRCLE, FIgures.TRIANGLE, FIgures.SQUARE];
		public static const FIGURE_COLORS:Array = [Colors.BLUE, Colors.GREEN, Colors.RED];
		public static const FILL:Array = [Fill.BORDER, Fill.FILL, Fill.GRADIENT];
		public static const FIGURES_AMOUNT:Array = [1 , 2, 3];
		
		
		
		
		public function cloneVO():SymbolVO {
			var symVO:SymbolVO	= new SymbolVO();
			symVO.bgColor		= bgColor;
			symVO.bgImageAlpah 	= bgImageAlpah;
			symVO.borderStyle	= borderStyle;
			symVO.figure		= figure;
			symVO.figureColor	= figureColor;
			symVO.fill			= fill;
			symVO.figuresAmount = figuresAmount;
			return symVO;
		}
		
		public function makeSymbolFromVO(symVO:SymbolVO):void {
			makeSymbol(symVO.bgColor, symVO.bgImageAlpah, symVO.borderStyle, symVO.figure, symVO.figureColor, symVO.fill, symVO.figuresAmount);
		}
		
		public function makeSymbol(bgColor:uint = NaN, bgImageAlpha:String = "", borderStyle:String = "", firure:String = "", firureColor:uint = NaN, fill:String = "", figuresAmount:uint = NaN):void {
			while(numChildren) {
				removeChildAt(0);
			}
			
			addChild(_container);
			
			this.bgColor = bgColor;
			this.bgImageAlpah = bgImageAlpha;
			this.borderStyle = borderStyle;
			this.figure = firure;
			this.figureColor = firureColor;
			this.fill = fill;
			this.figuresAmount = figuresAmount;
			
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(bgColor);
			bg.graphics.drawRect(3, 3, WIDTH-3, HEIGHT-3);
			bg.graphics.endFill();
			_container.addChild(bg);
			
			
			var bgImageSymbol:ClipSymbol = new ClipSymbol();
			switch (bgImageAlpha) {
				case BGAlphaStyle.HORIZONTAL_LINES:
					bgImageSymbol.gotoAndStop(11);
					bgImageSymbol.y = 22;
					break;
				
				case BGAlphaStyle.NO_LINES:
					bgImageSymbol.visible = false;
					break;
				
				case BGAlphaStyle.DIAGONAL_LINES:
					bgImageSymbol.gotoAndStop(12);
					break;
			}
			_container.addChild(bgImageSymbol);
			
			var borderSymbol:ClipSymbol = new ClipSymbol();
			switch (borderStyle) {
				case BorderStyle.DASHED:	borderSymbol.gotoAndStop(14);	break;
				case BorderStyle.DOTS:		borderSymbol.gotoAndStop(15);	break;
				case BorderStyle.SOLID:		borderSymbol.gotoAndStop(13);	break;
			}
			_container.addChild(borderSymbol);
			
			var canvas:Sprite = new Sprite();
			canvas.graphics.beginFill(firureColor);
			canvas.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			canvas.graphics.endFill();
			
			
			var figSymbol:ClipSymbol = new ClipSymbol();
			switch (firure) {
				case FIgures.CIRCLE:
					if (fill == Fill.FILL)
						figSymbol.gotoAndStop(7);
					if (fill == Fill.BORDER)
						figSymbol.gotoAndStop(9);
					if (fill == Fill.GRADIENT)
						figSymbol.gotoAndStop(8);
					break;
				
				case FIgures.SQUARE:
					if (fill == Fill.FILL)
						figSymbol.gotoAndStop(1);
					if (fill == Fill.BORDER)
						figSymbol.gotoAndStop(3);
					if (fill == Fill.GRADIENT)
						figSymbol.gotoAndStop(2);
					break;
				
				case FIgures.TRIANGLE:
					if (fill == Fill.FILL)
						figSymbol.gotoAndStop(4);
					else if (fill == Fill.BORDER)
						figSymbol.gotoAndStop(6);
					else if (fill == Fill.GRADIENT)
						figSymbol.gotoAndStop(5);
					break;
			}
			
			
			var fig:BitmapData = new BitmapData(figSymbol.width, figSymbol.height, true, 0x00000000);
			fig.draw(figSymbol);
			figuresAmount = 3;
			var bd:BitmapData = ImageUtils.getColorized(fig, figureColor);
			switch (figuresAmount) {
				case 1:
					var bitmap:Bitmap = new Bitmap(bd);
					addChild(bitmap);
					bitmap.x = -figSymbol.width / 2;
					bitmap.y = -figSymbol.height / 2;
					break;
				
				case 2:
					var bitmap21:Bitmap = new Bitmap(bd);
					bitmap21.x += 10;
					bitmap21.scaleX =bitmap21.scaleY = .5;  
					addChild(bitmap21);
					var bitmap22:Bitmap = new Bitmap(bd);
					bitmap22.scaleX = bitmap22.scaleY = .5;
					bitmap22.x -= bitmap22.width + 10;
					bitmap21.y = bitmap22.y -= 30;
					addChild(bitmap22);
					break;
				
				case 3:
					var b31:Bitmap = new Bitmap(bd);
					var b32:Bitmap = new Bitmap(bd);
					var b33:Bitmap = new Bitmap(bd);
					
					b31.x += 10;
					b31.scaleX = b31.scaleY = .5;
					b32.scaleX = b32.scaleY = .5;
					b33.scaleX = b33.scaleY = .5;
					b32.x -= b32.width + 10;
					b33.x -= b33.width / 2;
					b33.y -= b33.height + 10;
					addChild(b33);
					addChild(b32);
					addChild(b31);
			}
			
			figSymbol = null;
			
			_container.x = -_container.width / 2;
			_container.y = -_container.height/ 2;
		}
		
		public function rotate():void {
			while(numChildren) {
				removeChildAt(0);
			}
			_container = null;
			_container = new Sprite();
			addChild(_container);
			
			var rubaha:ClipRubaha = new ClipRubaha();
			_container.addChild(rubaha);
			rubaha.gotoAndStop(_level);
			_container.x = -_container.width / 2;
			_container.y = -_container.height/ 2;
		}
		
		private var _level:uint;
		public function getSymbol(level:uint):void {
			_level = level;
			bgColor 		= BG_COLORS[Math.floor(Math.random() * BG_COLORS.length)]; //Цвет фона:
			bgImageAlpah 	= BG_IMAGE_ALPHAS[Math.floor(Math.random() * BG_IMAGE_ALPHAS.length)]; //Узор фона:
			borderStyle 	= BORDER_STYLES[Math.floor(Math.random() * BORDER_STYLES.length)]; //Граница фона:
			figure 			= FIGURES[Math.floor(Math.random() * FIGURES.length)]; //Фигура
			figureColor 	= FIGURE_COLORS[Math.floor(Math.random() * FIGURE_COLORS.length)]; //Цвет фигуры:
			fill 			= FILL[Math.floor(Math.random() * FILL.length)]; //Заливка
			figuresAmount 	= FIGURES_AMOUNT[Math.floor(Math.random() * FIGURES_AMOUNT.length)] ///Количество фигур:
			
			switch (level) {
				case 1:
					bgColor 		= Colors.WHITE;
					bgImageAlpah 	= BGAlphaStyle.NO_LINES;
					borderStyle 	= BorderStyle.SOLID;
					figuresAmount 	= 1;
					break;
				case 2:
					bgColor 		= Colors.WHITE;
					bgImageAlpah 	= BGAlphaStyle.NO_LINES;
					borderStyle 	= BorderStyle.SOLID;
					break;
				case 3: 
					bgColor 		= Colors.WHITE;
					bgImageAlpah 	= BGAlphaStyle.NO_LINES;
					break;
				case 4:
					bgColor 		= Colors.WHITE;
					bgImageAlpah 	= BGAlphaStyle.NO_LINES;
					break;
				case 5:
					bgColor 		= Colors.WHITE;
					
					break;
				case 6:
					bgColor 		= Colors.WHITE;
					break;
			}
			
			makeSymbol(bgColor, bgImageAlpah, borderStyle, figure, figureColor, fill, figuresAmount);
		}
	}
}