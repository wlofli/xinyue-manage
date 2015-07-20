/**
 * mzj add
 */
function dateShow(){
	var dateTime=new Date();
//    var hh=dateTime.getHours();
//    var mm=dateTime.getMinutes();
//    var ss=dateTime.getSeconds();

    var yy=dateTime.getFullYear();
    var MM=dateTime.getMonth()+1;
    var dd=dateTime.getDate();

    var week=dateTime.getDay();
	var days=["日","一","二","三","四","五","六"];

	var date = yy+"-"+MM+"-"+dd+" 星期"+days[week];

	$("#sysDate").html(date);
	$("#welDate").html(date);
	
	timeShow();
}

function timeShow(){
	var dateTime=new Date();
    var hh=dateTime.getHours();
    var mm=dateTime.getMinutes();
//    var ss=dateTime.getSeconds();
    
    if (mm < 10) {
		mm = "0" + mm;
	}
    $("#sysTime").html(hh+":"+mm);
    
    setTimeout(timeShow,1000);
}