function popAns(ansNum)
{
	ansHtml = '<HTML><HEAD><TITLE>Campbell Biology Self-Quiz</TITLE>'
	ansHtml += '</HEAD><BODY bgcolor="white">'
	ansHtml += '<TABLE border="0" width="100%">'
	ansHtml += '<TR><TD align="left">'
	ansHtml += '<B>Answer:</B>'
	ansHtml += '<P>' + ans[ansNum] + '</P>' 
	ansHtml += '</TD></TR>'
	ansHtml += '<TR><TD align="right">'
	ansHtml += '<A href="javascript:self.window.close()">Close</A>'
	ansHtml += '</TD></TR>'
	ansHtml += '</TABLE></BODY></HTML>'
	winString = 'menubar=no,toolbar=no,location=no,status=no,resizable=yes,width=400,height=200' 
	ansWin = window.open("empty.html","ansWin",winString)
	ansWin.document.clear()
	ansWin.document.open()
	ansWin.document.write(ansHtml)
	ansWin.document.close()
	return false
}
function showAns(theForm)
{
	imgName = "choice" + theForm.CORRECT.value
	document.images[imgName].src = "check.gif"
}
