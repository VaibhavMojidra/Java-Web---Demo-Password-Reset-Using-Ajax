<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style type="text/css">
#MyDiv{
	width:80vw;
	height: 80vh;
	margin-left:10vw;
	margin-top:10vh;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}
</style>
<script type="text/javascript">
	var username;
	var request;
	var ROTP;
	function  sendOTP() {
		username=document.getElementById('myusername').value;
		ROTP=Math.floor(100000 + Math.random() * 900000);
		sendInfo();
	}
	
	function TakeUser() {
		document.getElementById("MyDiv").innerHTML = "<input type='text' placeholder='Enter Username' id='myusername'/><br><button onclick='sendOTP()'>Next></button>";
	}
	
function sendInfo()  
{  
	document.getElementById('MyDiv').innerHTML="<h1>Please Wait...........<h1>";
		var v=username;  
		var url="SendOTP.jsp?User="+v+"&OTP="+ROTP;  
	  	if(window.XMLHttpRequest)
	  	{  
			request=new XMLHttpRequest();  
		}  
		else if(window.ActiveXObject)
		{  
			request=new ActiveXObject("Microsoft.XMLHTTP");  
		}  
	  	try
	  	{  
			request.onreadystatechange=getInfo;  
			request.open("GET",url,true);  
			request.send();
		}
	  	catch(e)
	  	{
	  		alert("Unable to connect to server");
		}  
}  

function ValidAndChange(){
	alert("Changing");
	//Changing Password code goes here u can use again AJAX too for same
}

function VerifyOTP() {
	var userotp=document.getElementById('OTPTB').value;
	if(userotp==ROTP){
		document.getElementById('MyDiv').innerHTML="<input type='text' placeholder='Password' id='PTB'/><br><input type='text' placeholder='Confirm Password' id='CPTB'/><br><button onclick='ValidAndChange()'>Verify</button>";
	}
	else{
		document.getElementById('MyDiv').innerHTML="<input type='text' placeholder='Enter OTP' id='OTPTB'/><br><button onclick='VerifyOTP()'>Verify</button><br><button onclick='sendInfo()'>Resend OTP</button><br><Label>Error: Invalid OTP</Label>";
	}
}

function getInfo()
{  
			if(request.readyState==4)
			{  
				var val=request.responseText;  
				if(val.match("EmailSent")){
					alert("OTP has been sent to ur registered email");
					document.getElementById('MyDiv').innerHTML="<input type='text' placeholder='Enter OTP' id='OTPTB'/><br><button onclick='VerifyOTP()'>Verify</button><br><button onclick='sendInfo()'>Resend OTP</button>";	
				}
				else{
					document.getElementById('MyDiv').innerHTML="Error";
				}
			}  
}
		
</script>
<title>Insert title here</title>
</head>
<body onload="TakeUser()">
<div id="MyDiv"></div>
</body>
</html>