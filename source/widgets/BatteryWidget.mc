using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class BatteryWidget extends Ui.Drawable {
	var _x, _y, _r;
	var battery, iconFont, microFont;
	
	function initialize(params) {
		Drawable.initialize(params);
        battery = Math.floor(Sys.getSystemStats().battery);

		iconFont = WatchUi.loadResource(Rez.Fonts.MicroIcons);
		microFont = WatchUi.loadResource(Rez.Fonts.MicroFont);

		_x = params[:x];
		_y = params[:y];
		_r = params[:r];
	}

	function onSettingsChanged() {
	}
	
	function draw(dc) {
		var batteryPercentage = battery/100;

		dc.setColor(Gfx.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.drawText(_x+2, _y-20, Graphics.FONT_TINY, battery.format(INTEGER_FORMAT) + "%", Graphics.TEXT_JUSTIFY_CENTER);
		//dc.drawText(_x+2, _y, Graphics.FONT_XTINY, "battery", Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Gfx.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
		dc.drawCircle(_x, _y, _r+10);
		System.println(App.getApp().isSleeping);
		if (!App.getApp().isSleeping) {
			dc.setPenWidth(10);
			dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, -60, 240);
			dc.setColor(Gfx.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
			dc.drawText(_x, _y+10+_r/2, iconFont, "", Graphics.TEXT_JUSTIFY_CENTER);
			dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, -60, (300*batteryPercentage)-60);
			dc.setPenWidth(1);
		}

	}

}