var docDateStr = "${doc.docDate}";
var docDateObj = new Date(docDateStr);

var formattedDate = docDateObj.toISOString().split('T')[0];
console.log(formattedDate);


const downloadPdf=()=>{
	
	console.log("실행");
	
}