module Utils {

    var position,r,t,w;

    function drawTickMarks(dc, start, count, divider, width, length, color) {            
        var p = position.get();
        var x = p[0];
        var y = p[1];
        
        dc.setClip(x-r, y-r, r*2, r*2);
        dc.setPenWidth(width);
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        
        for (var tick = start; tick < start+count; tick++) {
            var angle = 2 * Math.PI * tick / divider;
            var x1 = (r-3) * Math.sin(angle);
            var y1 = (r-3) * Math.cos(angle + Math.PI);
            
            var x2 = (r-3-length) * Math.sin(angle);
            var y2 = (r-3-length) * Math.cos(angle + Math.PI);
            
            if (length <= 1) {
                dc.drawPoint(x+x1,y+y1);
            } else {
                dc.drawLine(x+x1,y+y1,x+x2,y+y2);
            }
        }
    }
}