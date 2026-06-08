var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cors = require('cors');
var cookieParser = require('cookie-parser');
var session = require('express-session');
/*const redis = require('redis');
const redisStore = require('connect-redis')(session);
const client  = redis.createClient();*/
var upload = require('express-fileupload');
var logger = require('morgan');
var db_connect = require('./application/config/db.connect'); // connection string
const { createMyCnfFile } = require('./application/controllers/dbBackupController');

var app = express();
var indexRouter = require('./routes/index')(app.io); // commen router index.js
app.use(cors());
app.use(upload());
app.use(
    session({
        secret: 'utirna_admin',
        resave: true,
        saveUninitialized: true,
    })
); // setting session*/
/*app.use(session({
  secret: 'ssshhhhh',
  store: new redisStore({ host: 'localhost', port: 6379, client: client,ttl : 260}),
  saveUninitialized: false,
  resave: false
}));    */
// create a single instance or database
app.use(db_connect.myConnection(db_connect.mysql, db_connect.dbOptions, 'single'));


// app.use((req, res, next) => {
//     const oldJson = res.json;
//     const oldSend = res.send;

//     res.json = function (data) {
//         console.log("JSON RESPONSE:", req.url, res.headersSent);
//         return oldJson.call(this, data);
//     };

//     res.send = function (data) {
//         console.log("SEND RESPONSE:", req.url, res.headersSent);
//         return oldSend.call(this, data);
//     };

//     next();
// });

// view engine set

app.set('views', path.join(__dirname, 'application/views'));
app.set('view engine', 'pug');
app.use(function (req, res, next) {
    res.set(
        'Cache-Control',
        'no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0'
    );
    next();
});
app.use(
    logger(':method :url :status :res[content-length] - :response-time ms', {
        skip: (req, res) => {
            return (
                req.url.startsWith('/js') ||
                req.url.match(/\.(js|css|jpg|jpeg|png|gif|ico)$/) ||
                req.url.startsWith('/socket')
            );
        },
    })
);
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// create the mycnf fileo
createMyCnfFile();

app.use('/', indexRouter.index);
app.use('/admin', indexRouter.users);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

module.exports = app;
