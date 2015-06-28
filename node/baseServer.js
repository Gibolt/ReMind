var express = require("express");
var multer  = require('multer');
var fs      = require('fs');
var app     = express();
app.use('api', express.static('/root/www'));
app.use(express.static('/root/www/users'));
var done = false;
var port = 3000;

var photoDir = '/root/www/users/';
var uploading = {};
var user = "";

// https://codeforgeek.com/2014/11/file-uploads-using-node-js/
/*Configure the multer.*/
app.use(multer({
	dest : '/root/www/users/',

	// changeDest: function(dest, req, res) {
		// var stat = null;
		// var user = req.params.user;
		// // var dir  = '/root/www/users/' + user;
		// var dir  = dest + user;
		
		// try {
			// // using fs.statSync; NOTE that fs.existsSync is now deprecated; fs.accessSync could be used but is only nodejs >= v0.12.0
			// stat = fs.statSync(dest);
		// } catch(err) {
			// // for nested folders, look at npm package "mkdirp"
			// fs.mkdirSync(dest);
		// }

		// if (stat && !stat.isDirectory()) {
			// // Woh! This file/link/etc already exists, so isn't a directory. Can't save in it. Handle appropriately.
			// throw new Error('Directory cannot be created because an inode of a different type exists at "' + dest + '"');
		// }
		// return dest;
	// },

	rename : function(fieldname, filename, req, res) {
		var user = req.params.user;
		var dir  = '/root/www/users/' + user;
		var now  = new Date().toISOString();
		var date = now.slice(0,10).replace(/-/g,"");
		console.log("rename: " + req.params.user);
		
		// var path = dir + "/" + date;
		// console.log(path);
		// var file = fs.statSync(path);
		// if (file.isFile()) {
			// fs.unlinkSync(path);
		// }
		return date;
	},

	onFileUploadStart : function(file, req, res) {
		console.log(file.originalname + ' is starting ...');
		console.log("start: " + req.params.user);
	},

	onFileUploadComplete : function(file) {
		console.log(file.fieldname + ' uploaded to  ' + file.path);
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
