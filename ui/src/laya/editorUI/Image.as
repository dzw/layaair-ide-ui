package laya.editorUI
{
	import laya.display.Sprite;
	import laya.ide.managers.IDEAPIS;
	import laya.renders.RenderSprite;
	import laya.editorUI.Loader;
	import laya.resource.Texture;
	import laya.utils.Handler;
	import laya.editorUI.AutoBitmap;
	import laya.editorUI.Component;
	import laya.editorUI.UIUtils;
	import laya.events.Event;
	
	/**
	 * 资源加载完成后调度。 
	 * 
	 * @eventType Event.LOADED
	 */	
	[Event(name = "loaded",type="laya.events.Event")]
	
	
	/**
	 * <code>Image</code> 类是用于表示位图图像或绘制图形的显示对象。
	 * 
	 * 
	 * @example 以下示例代码，创建了一个新的 <code>Image</code> 实例，设置了它的皮肤、位置信息，并添加到舞台上。
	 * <listing version="3.0">
	 *	package
	 *	 {
	 *		import laya.ui.Image;	
	 *		public class Image_Example
	 *		{
	 *			public function Image_Example()
	 *			{
	 *				Laya.init(640, 800);//设置游戏画布宽高。
	 *				Laya.stage.bgColor = "#efefef";//设置画布的背景颜色。
	 *				onInit();
	 *			}		
	 *			private function onInit():void
	 *	 		{
	 *				var bg:Image = new Image("resource/ui/bg.png");//创建一个 Image 类的实例对象 bg ,并传入它的皮肤。
	 *				bg.x = 100;//设置 bg 对象的属性 x 的值，用于控制 bg 对象的显示位置。
	 *				bg.y = 100;//设置 bg 对象的属性 y 的值，用于控制 bg 对象的显示位置。
	 *				bg.sizeGrid = "40,10,5,10";//设置 bg 对象的网格信息。
	 *				bg.width = 150;//设置 bg 对象的宽度。
	 *				bg.height = 250;//设置 bg 对象的高度。
	 *				Laya.stage.addChild(bg);//将此 bg 对象添加到显示列表。
	 *			
	 *				var image:Image = new Image("resource/ui/image.png");//创建一个 Image 类的实例对象 image ,并传入它的皮肤。
	 *				image.x = 100;//设置 image 对象的属性 x 的值，用于控制 image 对象的显示位置。
	 *				image.y = 100;//设置 image 对象的属性 y 的值，用于控制 image 对象的显示位置。
	 *				Laya.stage.addChild(image);//将此 image 对象添加到显示列表。
	 *			}
	 *		}
	 *	 }
	 * </listing>
	 * <listing version="3.0">
	 * Laya.init(640, 800);//设置游戏画布宽高
	 * Laya.stage.bgColor = "#efefef";//设置画布的背景颜色
	 * onInit();
	 * function onInit() {
	 *     var bg = new laya.ui.Image("resource/ui/bg.png");//创建一个 Image 类的实例对象 bg ,并传入它的皮肤。
	 *     bg.x = 100;//设置 bg 对象的属性 x 的值，用于控制 bg 对象的显示位置。
	 *     bg.y = 100;//设置 bg 对象的属性 y 的值，用于控制 bg 对象的显示位置。
	 *     bg.sizeGrid = "40,10,5,10";//设置 bg 对象的网格信息。
	 *     bg.width = 150;//设置 bg 对象的宽度。
	 *     bg.height = 250;//设置 bg 对象的高度。
	 *     Laya.stage.addChild(bg);//将此 bg 对象添加到显示列表。
	 * 
	 *     var image = new laya.ui.Image("resource/ui/image.png");//创建一个 Image 类的实例对象 image ,并传入它的皮肤。
	 *     image.x = 100;//设置 image 对象的属性 x 的值，用于控制 image 对象的显示位置。
	 *     image.y = 100;//设置 image 对象的属性 y 的值，用于控制 image 对象的显示位置。
	 *     Laya.stage.addChild(image);//将此 image 对象添加到显示列表。
	 * }
	 * </listing>
	 * <listing version="3.0">
	 * class Image_Example {
	 *     constructor() {
	 *         Laya.init(640, 800);//设置游戏画布宽高。
	 *         Laya.stage.bgColor = "#efefef";//设置画布的背景颜色。
	 *         this.onInit();
	 *     }
	 *     private onInit(): void {
	 *         var bg: laya.ui.Image = new laya.ui.Image("resource/ui/bg.png");//创建一个 Image 类的实例对象 bg ,并传入它的皮肤。
	 *         bg.x = 100;//设置 bg 对象的属性 x 的值，用于控制 bg 对象的显示位置。
	 *         bg.y = 100;//设置 bg 对象的属性 y 的值，用于控制 bg 对象的显示位置。
	 *         bg.sizeGrid = "40,10,5,10";//设置 bg 对象的网格信息。
	 *         bg.width = 150;//设置 bg 对象的宽度。
	 *         bg.height = 250;//设置 bg 对象的高度。
	 *         Laya.stage.addChild(bg);//将此 bg 对象添加到显示列表。
	 *           
	 *         var image: laya.ui.Image = new laya.ui.Image("resource/ui/image.png");//创建一个 Image 类的实例对象 image ,并传入它的皮肤。
	 *         image.x = 100;//设置 image 对象的属性 x 的值，用于控制 image 对象的显示位置。
	 *         image.y = 100;//设置 image 对象的属性 y 的值，用于控制 image 对象的显示位置。
	 *         Laya.stage.addChild(image);//将此 image 对象添加到显示列表。
	 *     }
	 * }
	 * </listing>
	 * @see laya.ui.AutoBitmap 
	 */	
	public class Image extends Component
	{
		/**@private */		
		protected var _bitmap:AutoBitmap;
		/**@private */	
		protected var _skin:String;
		
		private var rec:Sprite;
		/**
		 * 创建一个 <code>Image</code> 实例
		 * @param skin 皮肤资源地址。
		 */		
		public function Image(skin:String = null)
		{
			rec = new Sprite();
			this.skin = skin;
			this.on(Event.ADDED, this, _addedToParent);
			callLater(checkIfShowRec);
		}
		private function _addedToParent():void
		{
			if (this.parent is GraphicContainer)
			{
				removeChildren();
			}else
			{
				
			}
		}
		/**@inheritDoc */
		override public function destroy(destroyChild:Boolean = true):void
		{
			super.destroy(true);
			_bitmap && _bitmap.destroy();
			_bitmap = null;
		}
		
		protected function checkIfShowRec():void
		{
			if (IDEAPIS.isPreview) return;
			rec.graphics.clear();
			rec.removeSelf();
			if (!skin)
			{
				rec.graphics.drawRect(0, 0, width?width:50, height?height:50, null, "#666666");
				addChild(rec);
			}
			repaint();
		}
		
		/**
		 * 释放此对象的皮肤资源。
		 */		
		public function dispose():void
		{
			destroy(true);
			Laya.loader.clearRes(_skin);
		}
		
		/**@inheritDoc */	
		override protected function createChildren():void
		{
			graphics = _bitmap = new AutoBitmap();
		}
		
		/**
		 * <p>对象的皮肤地址，以字符串表示。</p> 
		 * <p>如果资源未加载，则先加载资源，加载完成然后应用于此对象。</p>
		 * <b>注意：</b>资源加载完成后，会自动缓存至资源库中。
		 * 
		 * @return 
		 */		
		public function get skin():String
		{
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				if (value) {
					var source:Texture = Loader.getRes(value);
					if (source) this.source = source;
					else Laya.loader.load(_skin, Handler.create(this, setSource, [_skin]), null, Loader.IMAGE);
				} else {
					this.source = null;
				}
			}
		}
		
		
		/**
		 * @copy laya.ui.AutoBitmap#source 
		 * @return 
		 */		
		public function get source():Texture
		{
			return _bitmap.source;
		}
		
		public function set source(value:*):void {
			callLater(checkIfShowRec);
			if (!_bitmap) return;
			_bitmap.source = value;
			event(Event.LOADED);
			onCompResize();
			repaint();
		}
		
		/**
		 * @private
		 * 设置皮肤资源。 
		 * @param url
		 * @param value
		 */		
		protected function setSource(url:String, value:*):void
		{
			url === _skin && (this.source = value);
		}
		/**@inheritDoc */	
		override protected function get measureWidth():Number
		{
			return _bitmap.width;
		}
		/**@inheritDoc */	
		override protected function get measureHeight():Number
		{
			return _bitmap.height;
		}
		
		/**@inheritDoc */
		override public function set width(value:Number):void
		{
			super.width = value;
			_bitmap.width = value == 0?0.0000001:value;
			callLater(checkIfShowRec);
		}
		
		/**@inheritDoc */
		override public function set height(value:Number):void
		{
			super.height = value;
			_bitmap.height = value == 0?0.0000001:value;
			callLater(checkIfShowRec);
		}
		
		/**
		 * <p>当前实例的位图 <code>AutoImage</code> 实例的有效缩放网格数据。</p>
		 * <p>数据格式："上边距,右边距,下边距,左边距,是否重复填充(值为0：不重复填充，1：重复填充)"，以逗号分隔。
		 * <ul><li>例如："4,4,4,4,1"。</li></ul></p>
		 * @see laya.ui.AutoBitmap#sizeGrid
		 */
		public function get sizeGrid():String
		{
			if (_bitmap.sizeGrid) return _bitmap.sizeGrid.join(",");
			return null;
		}
		
		public function set sizeGrid(value:String):void
		{
			_bitmap.sizeGrid = UIUtils.fillArray(Styles.defaultSizeGrid, value, Number);
		}
		
		/**@inheritDoc */
		override public function set dataSource(value:*):void
		{
			_dataSource = value;
			if (value is String) skin = value;
			else super.dataSource = value;
		}
	}
}