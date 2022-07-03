using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class TicksWidget extends Ui.Drawable {
	
	function initialize(params) {
		Drawable.initialize(params);
	}

	function onSettingsChanged() {
	}
	
	function draw(dc) {
		drawTicks(dc, 4, .1, 180);
	}

	function drawTicks(dc, length, stroke, num) {
		dc.setColor(Gfx.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
		//dc.setPenWidth(dc.getWidth() * stroke);
    	var tickAngle = 360/num;
    	var center = dc.getWidth()/2;
    	for(var i = 0; i < num; i++) {
    		var angle = Math.toRadians(tickAngle * i);
    		var x1 = center + Math.round(Math.cos(angle) * (center-length));
    		var y1 = center + Math.round(Math.sin(angle) * (center-length));
    		var x2 = center + Math.round(Math.cos(angle) * (center));
    		var y2 = center + Math.round(Math.sin(angle) * (center));
    		
    		dc.drawLine(x1, y1, x2, y2);
    	}
    }

}