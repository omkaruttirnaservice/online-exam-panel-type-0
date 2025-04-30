var sendData = {
    _call:0,
    _error:[]
};
var middleware = {
    checkForPoolConnection: function (req, res, next){
        req.getConnection(function (err, connection) {
            if (err) {
                sendData._call = 999;
                sendData._error = "_ connection error";
                res.send(sendData);
            } else {
                res.pool = connection;
                next();
            }
        });
    },
    checkForPoolConnectionWithSession: function (req, res, next) {
        if (typeof(req.session.Exam) == 'undefined') {
                res.redirect('/'); 
        }
        req.getConnection(function (err, connection) {
            if (err) {
                sendData._call = 999;
                sendData._error = "_ connection error";
                res.send(sendData);
            } else {
                res.pool = connection;
                next();
            }
        });
    },
    checkForPoolConnectionWithAdminSession: function (req, res, next) {
        if (typeof(req.session.Admin) == 'undefined') {
                res.redirect('/admin'); 
                return false;
        }
        req.getConnection(function (err, connection) {
            if (err) {
                sendData._call = 999;
                sendData._error = "_ connection error";
                res.send(sendData);
            } else {
                res.pool = connection;
                next();
            }
        });
    },
   
}

module.exports = middleware;