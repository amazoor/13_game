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
		public static const BG_IMAGE_ALPHAS:Array = [ BGAlphaStyle.DIAGONAL_LINES, BGAlphaStyle.HORIZONTAL_LINES, BGAlphaStyle.VERTICAL_LINES ];
		public static const BORDER_STYLES:Array = [BorderStyle.DASHED, BorderStyle.DOTS, BorderStyle.SOLID];
		public static const FIGURES:Array = [ FIgures.CIRCLE, FIgures.TRIANGLE, FIgures.SQUARE];
		public static const FIGURE_COLORS:Array = [Colors.BLUE, Colors.GREEN, Colors.RED];
		public static const FILL:Array = [Fill.BORDER, Fill.FILL, Fill.GRADIENT];
		public static const FIGURES_AMOUNT:Array = [1 , 2, 3];
		
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
		
		private function makeSymbol(bgColor:uint = NaN, bgImageAlpha:String = "", borderStyle:String = "", firure:String = "", firureColor:uint = NaN, fill:String = "", figuresAmount:uint = NaN):void {
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
				
				case BGAlphaStyle.VERTICAL_LINES:
					bgImage = new Image("assets/symbols/symbol_11.png");
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
			shape.colorize(figureColor);
			addChild(shape);
			var f:Image = shape.clone();
			f.x = 100;
			addChild(f);
			/*var shape:Image = e.currentTarget as Image;
			var c:Bitmap;
			var bd:BitmapData = new BitmapData(shape.width, shape.height );
			for (var i:int = 0; i < shape.bitmap.width; i++) {
				for (var j:int = 0; j < shape.bitmap.height; j++) {
					if (shape.bitmap.bitmapData.getPixel(i, j) != 0) {
						var pix:uint = shape.bitmap.bitmapData.getPixel32(i, j);
						var alphaVal:uint = pix >> 24 & 0xFF;
						
						var argb:uint = 0;
						argb += (alphaVal<<24);
						argb += (figureColor);
						
						bd.setPixel32(i, j, argb);
					} else {
						bd.setPixel32(i, j, 0x00000000);
					}
				}	
			}*/
			
			/*c = new Bitmap(bd, "auto", true);
			c.scaleX = c.scaleY = .99;
			c.x = WIDTH / 2 - c.width / 2
			c.y = HEIGHT / 2 - c.height / 2;
			_container.addChild(c);
			//shape.bitmap = c;
			var clone:Image = shape.clone();
			addChild(clone); clone.x = 40;*/
			
		}
		
		public function getSymbol():void
		{
			bgColor = BG_COLORS[Math.floor(Math.random() * BG_COLORS.length)];
			bgImageAlpah = BG_IMAGE_ALPHAS[Math.floor(Math.random() * BG_IMAGE_ALPHAS.length)];
			borderStyle = BORDER_STYLES[Math.floor(Math.random() * BORDER_STYLES.length)];
			figure = FIGURES[Math.floor(Math.random() * FIGURES.length)];
			figureColor = FIGURE_COLORS[Math.floor(Math.random() * FIGURE_COLORS.length)];
			fill = FILL[Math.floor(Math.random() * FILL.length)];
			figuresAmount = FIGURES_AMOUNT[Math.floor(Math.random() * FIGURES_AMOUNT.length)]
			makeSymbol(bgColor, bgImageAlpah, borderStyle, figure, figureColor, fill, figuresAmount);
		}
	}
}