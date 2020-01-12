	function setTime() {
		++totalSeconds; // increase by one second
		document.getElementById("seconds").innerHTML = pad(totalSeconds % 60); // edit seconds
		document.getElementById("minutes").innerHTML = pad(parseInt(totalSeconds / 60)); // edit minutes
	}

	// adds padding/formatting for seconds and minutes in time served. Used in setTime()
	function pad(val) {
		var valString = val + "";
		if (valString.length < 2) {
			return "0" + valString;
		} else {
			return valString;
		}
	}
	// Because i'm using the href function to pass data, can't allow special characters unless they are specialy coded to pass
	function blockSpecialChar(e){
		var tmp = event.key;
		var rgx = /[^A-Za-z0-9,\.# -]/g;
		if (tmp.match(rgx))
			return false;
		else
			return true;
    }
	// So, byond turns number fields into normal textboxes. So, this makes so only digits can be in that textbox
	function isNumber(event) {
		var test = event.key.replace(/[^0-9]/,''); // replaces any none digit with nothing
		if (test == '')
			return false; // feed the textbox nothing
		else
			return true; // feed the textbox the digit the user put in
	}
	// This clears out each input field
	function clearForm() {
		var fontColor = document.getElementById('invisText').style.color;
		var dataInputs = document.getElementsByClassName('data');
		var txtFields = document.getElementsByClassName('txt');
		for (var i=0;i<=2;i++) {
			dataInputs[i].value = '';
			txtFields[i].style.color = 'fontColor';
		}
	}