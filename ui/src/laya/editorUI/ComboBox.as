package laya.editorUI {
	import laya.display.Graphics;
	import laya.events.Event;
	import laya.ide.managers.IDEAPIS;
	import laya.maths.Point;
	import laya.utils.Handler;
	
	/**
	 * 当用户更改 <code>ComboBox</code> 组件中的选定内容时调度。
	 * @eventType laya.events.Event
	 * @internal selectedIndex属性变化时调度。
	 * @author lai
	 */
	[Event(name = "change", type = "laya.events.Event")]
	
	/**
	 * <code>ComboBox</code> 组件包含一个下拉列表，用户可以从该列表中选择单个值。
	 *
	 * @example 以下示例代码，创建了一个 <code>ComboBox</code> 实例。
	 * <listing version="3.0">
	 * package
	 *	{
	 *		import laya.ui.ComboBox;
	 *		import laya.utils.Handler;
	 *
	 *		public class ComboBox_Example
	 *		{
	 *			public function ComboBox_Example()
	 *			{
	 *				Laya.init(640, 800);//设置游戏画布宽高。
	 *				Laya.stage.bgColor = "#efefef";//设置画布的背景颜色。
	 *				Laya.loader.load("resource/ui/button.png", Handler.create(this,onLoadComplete));//加载资源。
	 *			}
	 *
	 *			private function onLoadComplete():void
	 *			{
	 *				trace("资源加载完成！");
	 *				var comboBox:ComboBox = new ComboBox("resource/ui/button.png", "item0,item1,item2,item3,item4,item5");//创建一个 ComboBox 类的实例对象 comboBox ,传入它的皮肤和标签集。
	 *				comboBox.x = 100;//设置 comboBox 对象的属性 x 的值，用于控制 comboBox 对象的显示位置。
	 *				comboBox.y = 100;//设置 comboBox 对象的属性 x 的值，用于控制 comboBox 对象的显示位置。
	 *				comboBox.selectHandler = new Handler(this, onSelect);//设置 comboBox 选择项改变时执行的处理器。
	 *				Laya.stage.addChild(comboBox);//将此 comboBox 对象添加到显示列表。
	 *			}
	 *
	 *			private function onSelect(index:int):void
	 *			{
	 *				trace("当前选中的项对象索引： ",index);
	 *			}
	 *
	 *		}
	 *
	 *	}
	 * </listing>
	 * <listing version="3.0">
	 * Laya.init(640, 800);//设置游戏画布宽高。
	 * Laya.stage.bgColor = "#efefef";//设置画布的背景颜色。
	 * Laya.loader.load("resource/ui/button.png",laya.utils.Handler.create(this,loadComplete));//加载资源
	 * function loadComplete() {
	 *     console.log("资源加载完成！");
	 *     var comboBox = new laya.ui.ComboBox("resource/ui/button.png", "item0,item1,item2,item3,item4,item5");//创建一个 ComboBox 类的实例对象 comboBox ,传入它的皮肤和标签集。
	 *     comboBox.x = 100;//设置 comboBox 对象的属性 x 的值，用于控制 comboBox 对象的显示位置。
	 *     comboBox.y = 100;//设置 comboBox 对象的属性 x 的值，用于控制 comboBox 对象的显示位置。
	 *     comboBox.selectHandler = new laya.utils.Handler(this, onSelect);//设置 comboBox 选择项改变时执行的处理器。
	 *     Laya.stage.addChild(comboBox);//将此 comboBox 对象添加到显示列表。
	 * }
	 * function onSelect(index)
	 * {
	 *     console.log("当前选中的项对象索引： ",index);
	 * }
	 * </listing>
	 * <listing version="3.0">
	 * import ComboBox = laya.ui.ComboBox;
	 * import Handler = laya.utils.Handler;
	 * class ComboBox_Example {
	 *     constructor() {
	 *         Laya.init(640, 800);//设置游戏画布宽高。
	 *         Laya.stage.bgColor = "#efefef";//设置画布的背景颜色。
	 *         Laya.loader.load("resource/ui/button.png", Handler.create(this, this.onLoadComplete));//加载资源。
	 *     }
	 * 
	 *     private onLoadComplete(): void {
	 *         console.log("资源加载完成！");
	 *         var comboBox: ComboBox = new ComboBox("resource/ui/button.png", "item0,item1,item2,item3,item4,item5");//创建一个 ComboBox 类的实例对象 comboBox ,传入它的皮肤和标签集。
	 *         comboBox.x = 100;//设置 comboBox 对象的属性 x 的值，用于控制 comboBox 对象的显示位置。
	 *         comboBox.y = 100;//设置 comboBox 对象的属性 x 的值，用于控制 comboBox 对象的显示位置。
	 *         comboBox.selectHandler = new Handler(this, this.onSelect);//设置 comboBox 选择项改变时执行的处理器。
	 *         Laya.stage.addChild(comboBox);//将此 comboBox 对象添加到显示列表。
	 *     }
	 * 
	 *     private onSelect(index: number): void {
	 *         console.log("当前选中的项对象索引： ", index);
	 *     }
	 * 
	 * }
	 * 
	 * </listing>
	 */
	public class ComboBox extends Component {
		public var isPreview:Boolean = false;
		/**@private */
		protected var _visibleNum:int = 6;
		/**
		 * @private
		 */
		protected var _button:Button;
		/**
		 * @private
		 */
		protected var _list:List;
		/**
		 * @private
		 */
		protected var _isOpen:Boolean;
		/**
		 * @private
		 */
		protected var _scrollBar:VScrollBar;
		/**
		 * @private
		 */
		protected var _itemColors:Array = Styles.comboBoxItemColors;
		/**
		 * @private
		 */
		protected var _itemSize:int = 14;
		/**
		 * @private
		 */
		protected var _labels:Array = [];
		/**
		 * @private
		 */
		protected var _selectedIndex:int = -1;
		/**
		 * @private
		 */
		protected var _selectHandler:Handler;
		/**
		 * @private
		 */
		protected var _itemHeight:Number;
		/**
		 * @private
		 */
		protected var _listHeight:Number;
		
		/**
		 * 创建一个新的 <code>ComboBox</code> 组件实例。
		 * @param skin 皮肤资源地址。
		 * @param labels 下拉列表的标签集字符串。以逗号做分割，如"item0,item1,item2,item3,item4,item5"。
		 */
		public function ComboBox(skin:String = null, labels:String = null) {
			this.skin = skin;
			this.labels = labels;
		}
		
		/**@inheritDoc */
		override public function destroy(destroyChild:Boolean = true):void {
			super.destroy(destroyChild);
			_button && _button.destroy(destroyChild);
			_list && _list.destroy(destroyChild);
			_scrollBar && _scrollBar.destroy(destroyChild);
			_button = null;
			_list = null;
			_scrollBar = null;
			_itemColors = null;
			_labels = null;
			_selectHandler = null;
		}
		
		/**@inheritDoc */
		override protected function createChildren():void {
			addChild(_button = new Button());
			_list = new List();
			_list.selectEnable = true;
			_list.addChild(_scrollBar = new VScrollBar());
		}
		
		/**
		 * @private
		 */
		private function onListDown(e:Event):void {
			e.stopPropagation();
		}
		
		/**
		 * private
		 */
		private function onScrollBarDown(e:Event):void {
			e.stopPropagation();
		}
		
		/**@inheritDoc */
		override protected function initialize():void {
			_button.text.align = "left";
			_button.labelPadding = "0,0,0,5";
			
			_list.mouseHandler = Handler.create(this, onlistItemMouse, null, false);
			
			_scrollBar.name = "scrollBar";
			_scrollBar.y = 1;

			if (IDEAPIS.isPreview)
			{
				_button.on(Event.MOUSE_DOWN, this, onButtonMouseDown);
		
			_list.on(Event.CHANGE, this, onListChange);
			_list.on(Event.MOUSE_DOWN, this, onListDown);
			_scrollBar.on(Event.MOUSE_DOWN, this, onScrollBarDown);
			}
			
		}
		
		private function onButtonMouseDown(e:Event):void {
			
			//callLater(changeOpen);
			callLater(switchTo, [!_isOpen]);
		}
		
		/**
		 * @private
		 * 更改 <code>ComboBox</code> 组件中的选定内容。
		 */
		protected function onListChange(e:Event):void {
		//trace("change", _list.selectedIndex);
		selectedIndex = _list.selectedIndex;
		//isOpen = false;
		}
		
		/**
		 * @copy laya.ui.Button#skin
		 * @return
		 */
		public function get skin():String {
			return _button.skin;
		}
		
		public function set skin(value:String):void {
			if (_button.skin != value) {
				_button.skin = value;
				//callLater(changeList);
				changeList();
			}
		}
		
		/**@inheritDoc */
		override protected function get measureWidth():Number {
			return _button.width;
		}
		
		/**@inheritDoc */
		override protected function get measureHeight():Number {
			return _button.height;
		}
		
		/**
		 * @private (protected)
		 */
		protected function changeList():void {
			var labelWidth:Number = width - 2;
			var labelColor:String = _itemColors[2];
			_itemHeight = _itemSize+3;
			_list.itemRender = {type: "Box", child: [{type: "Label", props: {name: "label", x: 1,padding:"0,0,0,2", width: labelWidth, height: _itemHeight, fontSize: _itemSize, color: labelColor}}]};
			_list.repeatY = _visibleNum;
			_scrollBar.x = width - _scrollBar.width - 1;
			_list.refresh();
		}
		
		/**
		 * @private
		 * 下拉列表的鼠标事件响应函数。
		 * @param e
		 * @param index
		 */
		protected function onlistItemMouse(e:Event, index:int):void {
			var type:String = e.type;
			if (type === Event.MOUSE_OVER || type === Event.MOUSE_OUT) {
				var box:Box = _list.getCell(index);
				if (!box) return;
				var label:Label = box.getChildByName("label") as Label;
				if (type === Event.ROLL_OVER) {
					label.bgColor = _itemColors[0];
					label.color = _itemColors[1];
				} else {
					label.bgColor = null;
					label.color = _itemColors[2];
				}
			} else if (type === Event.CLICK) {
				selectedIndex = index;
				isOpen = false;
			}
		}
		
		/**
		 * @private
		 * @param value
		 */
		private function switchTo(value:Boolean):void {
			isOpen = value;
		}
		
		/**
		 * 更改下拉列表的打开状态。
		 */
		protected function changeOpen():void {
			isOpen = !_isOpen;
		}
		
		/**@inheritDoc */
		override public function set width(value:Number):void {
			super.width = value;
			_button.width = _width;
			callLater(changeItem);
			callLater(changeList);
		}
		
		/**@inheritDoc */
		override public function set height(value:Number):void {
			super.height = value;
			_button.height = _height;
		}
		
		/**
		 * 标签集合字符串。
		 * @return
		 */
		public function get labels():String {
			return _labels.join(",");
		}
		
		public function set labels(value:String):void {
			if (_labels.length > 0) selectedIndex = -1;
			if (value) _labels = value.split(",");
			else _labels.length = 0;
			callLater(changeItem);
		}
		
		/**
		 * 更改下拉列表。
		 */
		protected function changeItem():void {
			//赋值之前需要先初始化列表
			runCallLater(changeList);
			//显示边框
			_listHeight = _labels.length > 0 ? Math.min(_visibleNum, _labels.length) * _itemHeight : _itemHeight;
			_scrollBar.height = _listHeight - 2;
			//填充背景
			var g:Graphics = _list.graphics;
			g.clear();
			g.drawRect(0, 0, width - 1, _listHeight, _itemColors[4], _itemColors[3]);
			//填充数据			
			var a:Array = _list.array || [];
			a.length = 0;
			for (var i:int = 0, n:int = _labels.length; i < n; i++) {
				a.push({label: _labels[i]});
			}
			_list.array = a;
		}
		
		/**
		 * 表示选择的下拉列表项的索引。
		 * @return
		 */
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				_selectedIndex = value;
				
				if (_list.array) changeSelected();
				else callLater(changeSelected);
				
				event(Event.CHANGE, [Event.EMPTY.setTo(Event.CHANGE, this, this)]);
				_selectHandler && _selectHandler.runWith(_selectedIndex);
			}
		}
		
		private function changeSelected():void {
			_list.selectedIndex = _selectedIndex;
			_button.label = selectedLabel;
		}
		
		/**
		 * 改变下拉列表的选择项时执行的处理器(默认返回参数index:int)。
		 * @return
		 */
		public function get selectHandler():Handler {
			return _selectHandler;
		}
		
		public function set selectHandler(value:Handler):void {
			_selectHandler = value;
		}
		
		/**
		 * 表示选择的下拉列表项的的标签。
		 * @return
		 */
		public function get selectedLabel():String {
			return _selectedIndex > -1 && _selectedIndex < _labels.length ? _labels[_selectedIndex] : null;
		}
		
		public function set selectedLabel(value:String):void {
			selectedIndex = _labels.indexOf(value);
		}
		
		/**
		 * 获取或设置没有滚动条的下拉列表中可显示的最大行数。
		 * @return
		 */
		public function get visibleNum():int {
			return _visibleNum;
		}
		
		public function set visibleNum(value:int):void {
			_visibleNum = value;
			callLater(changeList);
		}
		
		/**
		 * 下拉列表项颜色。
		 * <p><b>格式：</b>"悬停或被选中时背景颜色,悬停或被选中时标签颜色,标签颜色,边框颜色,背景颜色"</p>
		 * @return
		 */
		public function get itemColors():String {
			return String(_itemColors)
		}
		
		public function set itemColors(value:String):void {
			_itemColors = UIUtils.fillArray(_itemColors, value, String);
			callLater(changeList);
		}
		
		/**
		 * 下拉列表项标签的字体大小。
		 * @return
		 */
		public function get itemSize():int {
			return _itemSize;
		}
		
		public function set itemSize(value:int):void {
			_itemSize = value;
			callLater(changeList);
		}
		
		/**
		 * 表示下拉列表的打开状态。
		 * @return
		 */
		public function get isOpen():Boolean {
			return _isOpen;
		}
		
		public function set isOpen(value:Boolean):void {
			if (_isOpen != value) {
				_isOpen = value;
				_button.selected = _isOpen;
				if (_isOpen) {
					Point.EMPTY.setTo(0, 0);
					var p:Point = localToGlobal(Point.EMPTY);
					var py:Number = p.y + _button.height;
					py = py + _listHeight <= Laya.stage.width ? py : p.y - _listHeight;
					_list.pos(p.x, py);
					Laya._currentStage.addChild(_list);
					if (IDEAPIS.isPreview)
					{
						Laya.stage.on(Event.MOUSE_DOWN, this, removeList);
					}
					
					_list.selectedIndex = _selectedIndex;
				} else {
					_list.removeSelf();
					Laya.stage.off(Event.MOUSE_DOWN, this, removeList);
				}
			}
		}
		
		/**
		 * 关闭下拉列表。
		 */
		protected function removeList(e:Event):void {
			isOpen = false;
		}
		
		/**
		 * 滚动条皮肤。
		 * @return
		 */
		public function get scrollBarSkin():String {
			return _scrollBar.skin;
		}
		
		public function set scrollBarSkin(value:String):void {
			_scrollBar.skin = value;
		}
		
		/**
		 * <p>当前实例的位图 <code>AutoImage</code> 实例的有效缩放网格数据。</p>
		 * <p>数据格式："上边距,右边距,下边距,左边距,是否重复填充(值为0：不重复填充，1：重复填充)"，以逗号分隔。
		 * <ul><li>例如："4,4,4,4,1"</li></ul></p>
		 * @see laya.ui.AutoBitmap.sizeGrid
		 * @return
		 */
		public function get sizeGrid():String {
			return _button.sizeGrid;
		}
		
		public function set sizeGrid(value:String):void {
			_button.sizeGrid = value;
		}
		
		/**
		 * 获取对 <code>ComboBox</code> 组件所包含的 <code>VScrollBar</code> 滚动条组件的引用。
		 * @return
		 */
		public function get scrollBar():VScrollBar {
			return _scrollBar;
		}
		
		/**
		 * 获取对 <code>ComboBox</code> 组件所包含的 <code>Button</code> 组件的引用。
		 */
		public function get button():Button {
			return _button;
		}
		
		/**
		 * 获取对 <code>ComboBox</code> 组件所包含的 <code>List</code> 列表组件的引用。
		 * @return
		 */
		public function get list():List {
			return _list;
		}
		
		/**@inheritDoc */
		override public function set dataSource(value:*):void {
			_dataSource = value;
			if (value is int || value is String) selectedIndex = parseInt(value);
			else if (value is Array) labels = (value as Array).join(",");
			else super.dataSource = value;
		}
		
		/**
		 * 获取或设置对 <code>ComboBox</code> 组件所包含的 <code>Button</code> 组件的文本标签颜色。
		 * <p><b>格式：</b>upColor,overColor,downColor,disableColor</p>
		 * @return
		 */
		public function get labelColors():String {
			return _button.labelColors;
		}
		
		public function set labelColors(value:String):void {
			_button.labelColors = value;
		}
		
		/**
		 * 获取或设置对 <code>ComboBox</code> 组件所包含的 <code>Button</code> 组件的文本边距。
		 * <p><b>格式：</b>上边距,右边距,下边距,左边距</p>
		 * @return
		 */
		public function get labelPadding():String {
			return _button.text.padding.join(",");
		}
		
		public function set labelPadding(value:String):void {
			_button.text.padding = UIUtils.fillArray(Styles.labelPadding, value, Number);
		}
		
		/**
		 * 获取或设置对 <code>ComboBox</code> 组件所包含的 <code>Button</code> 组件的标签字体大小。
		 * @return
		 */
		public function get labelSize():int {
			return _button.text.fontSize;
		}
		
		public function set labelSize(value:int):void {
			_button.text.fontSize = value
		}
		
		/**
		 * 表示按钮文本标签是否为粗体字。
		 *
		 * @see laya.display.Text#bold
		 * @return
		 */
		public function get labelBold():Boolean {
			return _button.text.bold;
		}
		
		public function set labelBold(value:Boolean):void {
			_button.text.bold = value
		}
		
		/**
		 * 表示按钮文本标签的字体名称，以字符串形式表示。
		 *
		 * @see laya.display.Text#font
		 * @return
		 */
		public function get labelFont():String {
			return _button.text.font;
		}
		
		public function set labelFont(value:String):void {
			_button.text.font = value
		}
		
		/**
		 * 表示按钮的状态值。
		 *
		 * @see laya.ui.Button#stateNum
		 * @return
		 */
		public function get stateNum():int {
			return _button.stateNum;
		}
		
		public function set stateNum(value:int):void {
			_button.stateNum = value
		}
	}
}