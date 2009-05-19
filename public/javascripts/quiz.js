/**
 * @author Eddie
 */
function CheckQuiz(theform,num,startchar) {
	var resultmsg = "";
	var i;
	
	for (i=1;i<=num;i++) {
		if (theform.elements[startchar + i].value != "Y") {
			if (resultmsg == "") {
				resultmsg = "Your answers to the following questions " +
				"are incorrect : [" + i 
			}
			else {
				resultmsg = resultmsg + ", " + i 
			}
		}
	}
	if (resultmsg == "") {
		resultmsg = "Congratulations! Your answers are all correct." 
	}
	else {
		resultmsg = resultmsg + "]."
	}
	alert(resultmsg)
}
