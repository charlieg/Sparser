//*************** Begin browser sniffer and CSS deployment ***************
//////////////////////////////////////////////////////////
// Platform and browser sniffer
	
	//  determine platform
	if (navigator.platform.indexOf("Mac") != -1 ) {myPlat = "mac";}
	if (navigator.platform.indexOf("Win" ) != -1 ) {myPlat = "pc";}
	
	//  determine browser type
    if (navigator.appName.indexOf("Netscape") != -1 ) {myBrws = "_ie";}
	if (navigator.appName.indexOf("Microsoft Internet Explorer") != -1 ) {myBrws = "_ie";}
	
    //  determin browser version number
	if (myPlat=="mac") {
	if (navigator.appVersion.indexOf("3.") != -1 ) {myBv = "4";} //mac nn3
	if (navigator.appVersion.indexOf("4.") != -1 ) {myBv = "4";} // mac nn4
	if (navigator.appVersion.indexOf("5.") != -1 ) {myBv = "5";}// mac nn6
	if (navigator.appVersion.indexOf("MSIE 3.") != -1 ) {myBv = "4";}// mac ie3
	if (navigator.appVersion.indexOf("MSIE 4.") != -1 ) {myBv = "4";}// mac ie4
	if (navigator.appVersion.indexOf("MSIE 5.") != -1 ) {myBv = "5";}// mac ie5
	if (navigator.appVersion.indexOf("MSIE 6.") != -1 ) {myBv = "5";}// mac ie6
	}
 
	// use single .css file for pc
	if (myPlat=="pc") { {myBv = "";} {myBrws = "";}	}
	
	// failsafe for unix, linux etc.
	if (myPlat==""){ {myPlat = "pc";} {myBv = "";} {myBrws = "";}	}

	// adopt 'myroot' from parent page, concatonate variables and write css filename
	document.write("<LINK REL='Stylesheet' HREF='../css/" + myPlat + myBrws + myBv + ".css'>");

//*************** End browser sniffer and CSS deployment ***************

//spawn window function
function spawnWindow(theURL,winName,properties) { 
  window.open(theURL,winName,properties);
  //window.moveTo(400, 200)
}

//netscape resize fix
 if(!window.saveInnerWidth) {
   window.onresize = resizeIt;
   window.saveInnerWidth = window.innerWidth;
   window.saveInnerHeight = window.innerHeight;
 }

 function resizeIt() {
     if (saveInnerWidth < window.innerWidth || 
         saveInnerWidth > window.innerWidth || 
         saveInnerHeight > window.innerHeight || 
         saveInnerHeight < window.innerHeight ) 
     {
        // window.history.go(0);
        location.reload();
     }
 }

 
//open a window, then write to it  for thumbnails
function getProperties(whichFigure,imageName,imageSource,imgWidth,imgHeight) { 
   var  properties = "<html><head><style type='text/css'>.figure_caption {color:#000000; font-family: Arial, Helvetica, sans-serif; font-size:11px; font-weight: normal;} .text {color:#000000; font-family: Arial, Helvetica, sans-serif; font-size:12px; font-weight: normal;}</style><title>" + whichFigure + "</title></head><body bgColor='#ffffff' leftmargin='0' topmargin='0' marginheight='0' marginwidth='0'><img src='"+imageName+"'  border='0' name='bigFigure' /><div align='right' class='text'><a href='javascript:window.close();'><img src='../img/nav/close.gif' width='42' height='18' border='0' alt='close window'></a>&nbsp;&nbsp;</div></body></html>";
   return properties; 
   } 
   
function bigFig(whichFigure,imageName,imageSource) {
//determine what popup window size should be based on thumbnail size
var imgHeight=document.images['my'+imageSource].height
var imgWidth=document.images['my'+imageSource].width
var figHeight= eval(imgHeight*3+40)
var figWidth= eval(imgWidth*3)

var newWindow = window.open("","video","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=auto,resizable=1,height="+figHeight+",width="+figWidth+"");
newWindow.document.write(getProperties(whichFigure,imageName,imageSource,imgWidth,imgHeight));
newWindow.document.close();
newWindow.focus();
   }
   
function openmovie(mUrl)
{
mov_window =
window.open(mUrl,'mov_window','toolbar=0,location=0,status=0,menubar=0,scrollbars=auto,resizable=1,width=400,height=500');
//mov_window.moveTo(0,0);
}
   
function opentutorial(tUrl)
{
tut_window =
window.open(tUrl,'tut_window','toolbar=0,location=0,status=0,menubar=0,scrollbars=auto,resizable=1,width=800,height=600');
//tut_window.moveTo(0,0);
}
 
//open a window, then write to it for glossary
function glossProperties(gLetter) { 
   var  gProperties = "<html><head><meta http-equiv='content-type' content='text/html;charset=iso-8859-1'><title>The Cosmic Perspective 2e - Glossary</title></head><frameset rows='50,*' framespacing='0' border='1' frameborder='NO'><frame src='../gloss/top.htm' name='top' scrolling='auto' noresize><frame src='../gloss/main.htm#"+gLetter+"' name='main'></frameset><noframes><body><center><br><br>This site uses frames.<br>Please upgrade your browser.</body></noframes></html>";
   return gProperties; 
   } 
   
function openGloss(gLetter) {

var gWindow = window.open("","gloss","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=auto,resizable=1,height=500,width=500");
gWindow.document.write(glossProperties(gLetter));
gWindow.document.close();
gWindow.focus();
   }

//navigation(): handle clicks in navigation frame
function navigate(mainDoc,navDoc)
{
	if(mainDoc!="")
	{
		top.frames.main.location = mainDoc;
	}
	if(navDoc!="")
	{
		top.frames.leftnav.location = navDoc;
	}
}

//popNote(): open footnote popup window
function popNote(chapNum,noteNum)
{
	noteName = "note" + chapNum + "-" + noteNum + ".htm"
	winString = 'menubar=no,toolbar=no,location=no,status=no,scrollbars=yes,resizable=yes,width=400,height=400' 
	noteWin = window.open(noteName,"noteWin",winString)
	noteWin.focus()
}

//bcEbookIdx():  Load page and nav from index
function bcEbookIdx(idxStr)
{
	//parse code string
	idxCodes = idxStr.split(".")
		//0:chap  1:#2head  2:para
	//trim leading 0 from codes from chap and head
	for(i=0;i<=1;i++)
	{
		idxCodes[i] = (idxCodes[i].substr(0,1)=="0")?idxCodes[i].substr(1,1):idxCodes[i]
	}
	//build hrefs
	mainDoc = "../htm/"
	navDoc = "../htm/"
	if(idxCodes[1]=="0")
	{
		//if #2head is 0, go to chapter
		mainDoc += "chap" + idxCodes[0] + ".htm"
		navDoc += "nav.chp" + idxCodes[0] + ".htm"
	}
	else
	{
		//go to #2head
		mainDoc += "chap" + idxCodes[0] + "SEC2-"+ idxCodes[1] + ".htm"
		if(idxCodes.length>2 && idxCodes[2]!="0")
		{
			//add paragr hash
			mainDoc += "#para" + idxCodes[2]
		}
		navDoc += "nav.chp" + idxCodes[0] + ".htm"
	}
	//navigate
	navigate(mainDoc,navDoc)
}



//BC function to pop activity window
function bcPopActivity(actId)
{
	if(actId.length<3)
	{
		actLet = actId.substr(1)
		actChap = '0' + actId.substr(0,1)
	}
	else
	{
		actLet = actId.substr(2)
		actChap = actId.substr(0,2)
	}
	switch(actLet.toUpperCase())
	{
		case 'A':
			actNum = '01'
			break
		case 'B':
			actNum = '02'
			break
		case 'C':
			actNum = '03'
			break
		case 'D':
			actNum = '04'
			break
		case 'E':
			actNum = '05'
			break
		case 'F':
			actNum = '06'
			break
		case 'G':
			actNum = '07'
			break
		case 'H':
			actNum = '08'
			break
		case 'I':
			actNum = '09'
			break
		case 'J':
			actNum = '10'
			break
	}
	//change this prefix as appropriate for deployment environment!!
	prefix = "../../../" //path to assets relative to ebook
	popHref = prefix + "assets/interactivemedia/activities/H" + actChap + "/H" + actChap + actNum + "/st01/frame.html" 
	winString = 'menubar=no,toolbar=no,location=no,status=no,scrollbars=yes,resizable=yes,width=800,height=600' 
	popWin = window.open(popHref,"popWin",winString)
	popWin.focus()
}

function openExpr(page)
{
	bcExpr = window.open(page,"expr","toolbar=no,location=no,status=no,width=800,height=600")
}
