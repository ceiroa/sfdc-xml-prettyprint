@isTest
public with sharing class TextbrokerTestController {

	public String display { get; set; }
				
	public void HttpsTestCall() {
	HttpRequest request = new HttpRequest();
		request.setMethod('GET');
		//request.setEndpoint('https://success.salesforce.com/');
		//request.setEndpoint('https://twitter.com/');
		display = '-------REQUEST-----------\n';  
		display = display + request.toString();
		Http http = new Http();
		HttpResponse response = http.send(request);	
		display = display + '\n-------RESPONSE----------\n';
		display = display + response.getBody();
	}
	
	public void displayRequestResponse(HttpRequest request) {
		display = '-------REQUEST-----------\n'; 
	
		Dom.Document doc = request.getBodyDocument();
		if(doc == null) {
			display = display + request.toString() + '\n';
			display = display + request.getBody();		
		} else {
			dom.Xmlnode root = doc.getRootElement();
			if(root == null) {
				display = display + 'ERROR - There is no root element';
			} else {
				display = display + TextbrokerXmlPrinter.printNodeOpeningTag(root, 0);
				display = display + TextbrokerXmlPrinter.printNodeText(root);
				display = display + TextbrokerXmlPrinter.prettyPrint(root, 0);	
				display = display + TextbrokerXmlPrinter.printNodeClosingTag(root, 0);
			}
		}
		
		display = display + '\n-------RESPONSE----------\n'; 
		Http http = new Http();
		HttpResponse response = http.send(request);
		System.debug(LoggingLevel.WARN, '****RESPONSE: ' + response.getBody());
		display = display + response.getBody();
	}
}