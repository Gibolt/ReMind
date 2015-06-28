var express = require("express");
var multer  = require('multer');
var fs      = require('fs');
var app     = express();
app.use(express.static('/root/www'));
// app.use(express.static('/root/www/users'));
var done = false;
var port = 3000;

var photoDir = '/root/www/users/';
var uploading = {};
var user = "";

// https://codeforgeek.com/2014/11/file-uploads-using-node-js/
/*Configure the multer.*/
app.use(multer({
	dest : '/root/www/users/',

	rename : function(fieldname, filename, req, res) {
		console.log(fieldname);
		console.log(filename);
		console.log(req.originalUrl);
		var user = req.originalUrl.split('/').pop();
		var dir  = '/root/www/users/' + user;
		var now  = new Date().toISOString();
		var date = now.slice(0,10).replace(/-/g,"");
		console.log("rename: " + user);
		try {
			fs.mkdirSync(dir);
		}
		catch(e) {
		}
		return '/' + user + '/' + date;
	},

	onFileUploadStart : function(file, req, res) {
		console.log(file.originalname + ' is starting ...');
		console.log("start: " + req.params.user);
	},

	onFileUploadComplete : function(file) {
		console.log(file.fieldname + ' uploaded to  ' + file.path);
		var noExt = file.path.split('.');
		noExt.pop();
		noExt = noExt.join('.');
		fs.rename(file.path, noExt);
		console.log("renaming: " + noExt);
		done = true;
	},
}));

/*Handling routes.*/
app.get('/',function(req,res){
	res.sendfile("index.html");
});

app.post('/api/photo/:user',function(req, res){
	if (done == true) {
		console.log(req.files);
		console.log("post: " + req.params.user);
		res.end("File uploaded.");
		done = false;
	}
});

app.post('/api/photos/:user',function(req, res){
	var user = req.params.user;
	console.log(user);
	var list = getAllFiles(user);
	res.send(list);
});

function getAllFiles(user) {
	var path = photoDir + "/" + user;
	var list = fs.readdirSync(path);
	return list;
}

/*Run the server.*/
app.listen(port, function(){
    console.log("Starting server on port: " + port);
});
