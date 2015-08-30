var xmlHttp = createXmlHttpRequestObject();

function createXmlHttpRequestObject(){
	var xmlHttp;

	if(window.ActiveXObject){
		try{
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}catch(e){
			xmlHttp = false;
		}
	}
	else{
		try{
			xmlHttp = new XMLHttpRequest();
		}catch(e){
			xmlHttp = false;
		}
	}
	if(!xmlHttp)
		alert("cant create that object hoss!");
	else
		return xmlHttp;
}	

function process(){
	if(xmlHttp.readyState==0 || xmlHttp.readyState==4){
		user1 = encodeURIComponent(document.getElementById("user1").value);
		user2 = encodeURIComponent(document.getElementById("user2").value);
		xmlHttp.open("GET","../SUC.py",true);
		xmlHttp.onreadystatechange = handleServerResponse;
		xmlHttp.send(null);
	}else{
		setTimeout('process()', 1000);
	}
}

function handleServerResponse(){
	if(xmlHttp.readyState==4){
		if(xmlHttp.status==200){
			xmlResponse = xmlHttp.responseXML;
			xmlDocumentElement = xmlResponse.documentElement;
			message = xmlDocumentElement.firstChild.data
			document.getElementById("underInput").innerHTML = '<span style="color:blue">' + message + '</span>';
			setTimeout('process()', 1000);
		}else{
			alert('Something Went Wrong !');
		}
	}
}
