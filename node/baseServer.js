var express = require("express");
var multer  = require('multer');
var app  = express();
var done = false;
var port = 3000;

// https://codeforgeek.com/2014/11/file-uploads-using-node-js/
/*Configure the multer.*/
app.use(multer({
	dest : './uploads/',

	rename : function(fieldname, filename) {
		return filename + Date.now();
	},

	onFileUploadStart : function(file) {
		console.log(file.originalname + ' is starting ...');
	},

	onFileUploadComplete : function(file) {
		console.log(file.fieldname + ' uploaded to  ' + file.path);
		done = true;
	}
}));

/*Handling routes.*/
app.get('/',function(req,res){
	res.sendfile("index.html");
});

app.post('/api/photo',function(req,res){
	if (done == true){
		console.log(req.files);
		res.end("File uploaded.");
	}
});

/*Run the server.*/
app.listen(port, function(){
    console.log("Starting server on port: " + port);
});
