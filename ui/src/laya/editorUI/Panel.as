package laya.editorUI {
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.ide.managers.IDEAPIS;
	import laya.maths.Rectangle;
	import laya.events.Event;
	
	/**
	 * <code>Panel</code> 是一个面板容器类。
	 * 
	 * 
	 *  
	 * @author yung
	 * 
	 */	
	public class Panel extends Box {
		
		/**@private */	
		protected var _content:Box;
		/**@private */	
		protected var _vScrollBar:VScrollBar;
		/**@private */	
		protected var _hScrollBar:HScrollBar;
		/**
		 * 创建一个新的 <code>Panel</code> 类实例。
		 * 
		 * <p>在 <code>Panel</code> 构造函数中设置属性width、height的值都为100。</p>
		 */		
		public function Panel() {
			width = height = 100;
			_content.optimizeScrollRect = true;
		}
		
		/**@inheritDoc */		
		override public function destroy(destroyChild:Boolean = true):void {
			super.destroy(destroyChild);
			_content && _content.destroy(destroyChild);
			_vScrollBar && _vScrollBar.destroy(destroyChild);
			_hScrollBar && _hScrollBar.destroy(destroyChild);
			_vScrollBar = null;
			_hScrollBar = null;
			_content = null;
		}
		
		override public function destroyChildren():void {
			_content.destroyChildren();
		}
		
		/**@inheritDoc */			
		override protected function createChildren():void {
			super.addChild(_content = new Box());
		}
		
		/**@inheritDoc */
		override public function addChild(child:Node):Node {
			child.on(Event.RESIZE, this, onResize);
			callLater(changeScroll);
			return _content.addChild(child);
		}
		/**
		 * @private
		 * 子对象的 <code>Event.RESIZE</code> 事件侦听处理函数。
		 * @param e
		 */		
		private function onResize(e:Event):void {
			callLater(changeScroll);
		}
		
		/**@inheritDoc */
		override public function addChildAt(child:Node, index:int):Node {
			child.on(Event.RESIZE, this, onResize);
			callLater(changeScroll);
			return _content.addChildAt(child, index);
		}
		
		/**@inheritDoc */
		override public function removeChild(child:Node):Node {
			child.off(Event.RESIZE, this, onResize);
			callLater(changeScroll);
			return _content.removeChild(child);
		}
		
		
		/**@inheritDoc */
		override public function removeChildAt(index:int):Node {
			getChildAt(index).off(Event.RESIZE, this, onResize);
			callLater(changeScroll);
			return _content.removeChildAt(index);
		}
		
		/**@inheritDoc */
		override public function removeChildren(beginIndex:int = 0, endIndex:int=0x7fffffff):Node {
			for (var i:int = _content.numChildren - 1; i > -1; i--) {
				_content.removeChildAt(i);
			}
			callLater(changeScroll);
			return this;
		}
			
		/**@inheritDoc */
		override public function getChildAt(index:int):Node {
			return _content.getChildAt(index);
		}
		
	
		/**@inheritDoc */
		override public function getChildByName(name:String):Node {
			return _content.getChildByName(name);
		}
			
		/**@inheritDoc */
		override public function getChildIndex(child:Node):int {
			return _content.getChildIndex(child);
		}
				
		/**@inheritDoc */
		override public function get numChildren():int {
			return _content.numChildren;
		}
		
		/**@private */		
		private function changeScroll():void {
			var contentW:Number = contentWidth;
			var contentH:Number = contentHeight;
			
			var vscroll:ScrollBar = _vScrollBar;
			var hscroll:ScrollBar = _hScrollBar;
			
			var vShow:Boolean = vscroll && contentH > _height;
			var hShow:Boolean = hscroll && contentW > _width;
			var showWidth:Number = vShow ? _width - vscroll.width : _width;
			var showHeight:Number = hShow ? _height - hscroll.height : _height;
			
			//setContentSize(showWidth, showHeight);
			setContentSize(_width, _height);
			if (vscroll) {
				vscroll.x = _width - vscroll.width;
				vscroll.y = 0;
				vscroll.height = _height - (hShow ? hscroll.height : 0);
				vscroll.scrollSize = Math.max(_height * 0.033, 1);
				vscroll.thumbPercent = showHeight / contentH;
				if (isNaN(vscroll.value)) vscroll.value = 0;
				vscroll.setScroll(0, contentH - showHeight, vscroll.value);
			}
			if (hscroll) {
				hscroll.x = 0;
				hscroll.y = _height - hscroll.height;
				hscroll.width = _width - (vShow ? vscroll.width : 0);
				hscroll.scrollSize = Math.max(_width * 0.033, 1);
				hscroll.thumbPercent = showWidth / contentW;
				if (isNaN(hscroll.value)) hscroll.value = 0;
				hscroll.setScroll(0, contentW - showWidth, hscroll.value);
			}
		}
		/**
		 * @private
		 * 获取内容宽度（以像素为单位）。
		 * @return 
		 */		
		public function get contentWidth():Number {
			var max:Number = 0;
			for (var i:int = _content.numChildren - 1; i > -1; i--) {
				var comp:Sprite = _content.getChildAt(i) as Sprite;
				max = Math.max(comp.x + comp.width * comp.scaleX, max);
			}
			return max;
		}
		/**
		 * @private
		 * 获取内容高度（以像素为单位）。
		 * @return 
		 */		
		public function get contentHeight():Number {
			var max:Number = 0;
			for (var i:int = _content.numChildren - 1; i > -1; i--) {
				var comp:Sprite = _content.getChildAt(i) as Sprite;
				max = Math.max(comp.y + comp.height * comp.scaleY, max);
			}
			return max;
		}
		/**
		 * @private
		 * 设置内容的宽度、高度（以像素为单位）。
		 * @param width 宽度。
		 * @param height 高度。
		 */		
		private function setContentSize(width:Number, height:Number):void {
			var content:Box = _content;
			content.width = width;
			content.height = height;
			content.scrollRect || (content.scrollRect = new Rectangle());
			content.scrollRect.setTo(0, 0, width, height);
		}
		/**
		 * @inheritDoc
		 * @param value
		 */		
		override public function set width(value:Number):void {
			super.width = value;
			callLater(changeScroll);
		}
		
	
		/**@inheritDoc */
		override public function set height(value:Number):void {
			super.height = value;
			callLater(changeScroll);
		}
		
		
		/**
		 * 垂直方向滚动条皮肤。
		 * @return 
		 */		
		public function get vScrollBarSkin():String {
			return _vScrollBar ? _vScrollBar.skin : null;
		}
		
		public function set vScrollBarSkin(value:String):void {
			if (_vScrollBar == null) {
				super.addChild(_vScrollBar = new VScrollBar());
				if (IDEAPIS.isPreview)
				{
					_vScrollBar.on(Event.CHANGE, this, onScrollBarChange, [_vScrollBar]);
				}
				
				_vScrollBar.target = _content;
				callLater(changeScroll);
			}
			_vScrollBar.skin = value;
		}
		
		
	
		/**
		 * 水平方向滚动条皮肤。
		 * @return 
		 */		
		public function get hScrollBarSkin():String {
			return _hScrollBar ? _hScrollBar.skin : null;
		}
		
		public function set hScrollBarSkin(value:String):void {
			if (_hScrollBar == null) {
				super.addChild(_hScrollBar = new HScrollBar());
				if (IDEAPIS.isPreview)
				{
					_hScrollBar.on(Event.CHANGE, this, onScrollBarChange, [_hScrollBar]);
				}
				
				_hScrollBar.target = _content;
				callLater(changeScroll);
			}
			_hScrollBar.skin = value;
		}
		
		
		/**
		 * 垂直方向滚动条对象。
		 * @return 
		 */		
		public function get vScrollBar():ScrollBar {
			return _vScrollBar;
		}
		
		/**
		 * 水平方向滚动条对象。
		 * @return 
		 */		
		public function get hScrollBar():ScrollBar {
			return _hScrollBar;
		}
		
		/**
		 * 获取内容容器对象。 
		 * @return 
		 */		
		public function get content():Sprite {
			return _content;
		}
		override public function get comXml():Object 
		{
			return super.comXml;
		}
		
		override public function set comXml(value:Object):void 
		{
			super.comXml = value;
			content["comXml"] = value;
		}
		/**
		 * @private
		 * 滚动条的<code><code>Event.MOUSE_DOWN</code>事件侦听处理函数。</code>事件侦听处理函数。 
		 * @param scrollBar 滚动条对象。
		 * @param e
		 */		
		protected function onScrollBarChange(scrollBar:ScrollBar, e:Event):void {
			var rect:Rectangle = _content.scrollRect;
			if (rect) {
				var start:int = Math.round(scrollBar.value);
				scrollBar.isVertical ? rect.y = start : rect.x = start;
			}
		}
		
		/**
		 * <p>滚动内容容器至设定的垂直、水平方向滚动条位置。</p>
		 * @param x 水平方向滚动条属性value值。滚动条位置数字。
		 * @param y 垂直方向滚动条属性value值。滚动条位置数字。
		 */		
		public function scrollTo(x:Number = 0, y:Number = 0):void {
			if (vScrollBar) vScrollBar.value = y;
			if (hScrollBar) hScrollBar.value = x;
		}
		
		/**
		 * 刷新滚动内容。
		 */		
		public function refresh():void {
			changeScroll();
		}
	}
}