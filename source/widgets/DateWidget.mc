using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian as Date;
using Toybox.Lang;

class DateWidget extends Ui.Drawable {
	var _x, _y;
	var now, date, dateString;
	
	function initialize(params) {
		Drawable.initialize(params);
		        
		_x = params[:x];
		_y = params[:y];
	}

	function onSettingsChanged() {
	}
	
	function draw(dc) {
		
		now = Time.now();
		date = Date.info(now, Time.FORMAT_LONG);
		dateString = Lang.format("$1$", [date.day]);
		
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.fillRoundedRectangle(_x-10, _y-10, 30, 20, 2);
		
	    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		dc.drawText(
			_x+5,
			_y-2,
			Graphics.FONT_XTINY,
			dateString,
			Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER
		);
    	
	}

}