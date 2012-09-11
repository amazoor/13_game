package view
{
	import events.ImageEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.system.Security;
	
	import view.symbol.BGAlphaStyle;
	import view.symbol.BorderStyle;
	import view.symbol.Colors;
	import view.symbol.FIgures;
	import view.symbol.Fill;
	
	public class Symbol extends Sprite
	{
		private static const WIDTH:uint = 155;
		private static const HEIGHT:uint = 155;
		
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
		
		public function clone():Symbol {
			var clone:Symbol = new Symbol();
			clone.makeSymbol(bgColor, bgImageAlpah, borderStyle, figure, figureColor, fill, figuresAmount);
			return clone;
		}
		
		private var _imageSource:String;
		
		public function get imageSource():String
		{
			return _imageSource;
		}
		
		private var img:Image = new Image();
		public function set imageSource(value:String):void
		{
			while(numChildren) {
				removeChildAt(0);
			}
			
			_imageSource = value;
			img.addEventListener(ImageEvent.IMAGE_LOAD_COMPLETE, onImageLoaded);
			img.source = value;
			
			addChild(img);
			
		}
		
		protected function onImageLoaded(event:ImageEvent):void
		{
			img.x = -img.width / 2;
			img.y = -img.height/ 2;			
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
			bg.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			bg.graphics.endFill();
			_container.addChild(bg);
			
			var bgImage:Image;
			
			
			
			
			switch (bgImageAlpha) {
				case BGAlphaStyle.HORIZONTAL_LINES:
					bgImage = new Image("assets/symbols/symbol_11.png");
					bgImage.y = 22;
					break;
				
				case BGAlphaStyle.NO_LINES:
					bgImage = new Image();
					bgImage.rotation = 90;
					bgImage.scaleY = -1;
					bgImage.x = 22;
					break;
				
				case BGAlphaStyle.DIAGONAL_LINES:
					bgImage = new Image("assets/symbols/symbol_12.png");
					break;
			}
			
			_container.addChild(bgImage);
			
			var border:Image;
			switch (borderStyle) {
				case BorderStyle.DASHED:
					border = new Image("assets/symbols/symbol_14.png");
					break;
				
				case BorderStyle.DOTS:
					border = new Image("assets/symbols/symbol_15.png");
					break;
				
				case BorderStyle.SOLID:
					border = new Image("assets/symbols/symbol_13.png");
					break;
				
			}
			
			_container.addChild(border);
			
			var canvas:Sprite = new Sprite();
			canvas.graphics.beginFill(firureColor);
			canvas.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			canvas.graphics.endFill();
			
			
			var fig:Image = new Image();
			fig.addEventListener(ImageEvent.IMAGE_LOAD_COMPLETE, drawShape);
			switch (firure) {
				case FIgures.CIRCLE:
					if (fill == Fill.FILL)
						fig.source  = "assets/symbols/symbol_07.png";
					if (fill == Fill.BORDER)
						fig.source  = "assets/symbols/symbol_09.png";
					if (fill == Fill.GRADIENT)
						fig.source  = "assets/symbols/symbol_08.png";
					break;
				
				case FIgures.SQUARE:
					if (fill == Fill.FILL)
						fig.source  = "assets/symbols/symbol_01.png";
					if (fill == Fill.BORDER)
						fig.source  = "assets/symbols/symbol_03.png";
					if (fill == Fill.GRADIENT)
						fig.source  = "assets/symbols/symbol_02.png";
					break;
				
				case FIgures.TRIANGLE:
					if (fill == Fill.FILL)
						fig.source  = "assets/symbols/symbol_04.png";
					else if (fill == Fill.BORDER)
						fig.source  = "assets/symbols/symbol_06.png";
					else if (fill == Fill.GRADIENT)
						fig.source  = "assets/symbols/symbol_05.png";
					break;
			}
			
			_container.x = -_container.width / 2;
			_container.y = -_container.height/ 2;
		}
		
		private function drawShape(e:ImageEvent):void {
			
			var shape:Image = e.currentTarget as Image;
			addChild(shape);
			switch (figuresAmount) {
				case 1:
					shape.colorize(figureColor);
					shape.x = -shape.width / 2;
					shape.y = -shape.height / 2;
					break;
				
				case 2:
					shape.colorize(figureColor);
					shape.x += 10;
					shape.scaleX = shape.scaleY = .5;
					var copy1:Image = shape.clone();
					copy1.scaleX = copy1.scaleY = .5;
					copy1.x -= copy1.width + 10;
					shape.y = copy1.y -= 30;
					addChild(copy1);
					break;
				
				case 3:
					shape.colorize(figureColor);
					shape.x += 10;
					shape.scaleX = shape.scaleY = .5;
					var copy:Image = shape.clone();
					copy.scaleX = copy.scaleY = .5;
					var copyTop:Image = shape.clone();
					copyTop.scaleX = copyTop.scaleY = .5;
					copy.x -= copy.width + 10;
					copyTop.x -= copyTop.width / 2;
					copyTop.y -= copyTop.height + 10;
					addChild(copyTop);
					addChild(copy);
			}
		}
		
		public function getSymbol(level:uint):void {
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