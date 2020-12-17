require('date-utils');
const { v4: uuidv4 } = require('uuid');
var express = require('express');
var dt = new Date();


var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
    checkcommunication();
    res.send('respond with a resource');
});

/* GET users listing. */
router.get('/insert', function(req, res, next) {
    json = format('{"guid":"%s", "time":"%s"}', uuidv4(), dt.toISOString());
    console.log('json is: ', json);
    insertjson(json);
    res.send('respond with a resource');
});

module.exports = router;

const {format} = require('util')

// public function
exports.checkcommunication = function () {
    checkcommunication();
};

exports.insertjson = function (json) {
    insertjson(json);
};

function checkcommunication () {
    pool.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
        if (error) throw error;
        console.log('The solution is: ', results[0].solution);
    });
}

function insertjson(json) {
    //INSERT INTO json_vc (json)　VALUES ('{"_id":"58f884046309022eced97572","index":0,"guid":"7c70dc5e-5d98-4d94-8b88-e54050a11d71","isActive":true,"age":38,"eyeColor":"brown","name":"Mathews Cantrell","gender":"male","company":"NORSUP","email":"mathewscantrell@example.com","registered":"2016-12-25T03:44:09 -09:00","latitude":44.302937,"longitude":3.081185,"tags":["voluptate","ex","sit","proident","deserunt","pariatur","labore"],"greeting":"Hello, Mathews Cantrell! You have 9 unread messages.","favoriteFruit":"strawberry"}');
    sql = format('INSERT INTO json_vc (json) VALUES (\'%s\');', json)
    console.log('sql is:', sql)
    pool.query(sql, function (error, results, fields) {
        if (error) throw error;
        console.log('insert sql: ', sql);
    });
}

const mysql = require('mysql');
const pool  = mysql.createPool({
    connectionLimit : 10,
    host            : 'mysqljapanwestsmc.mysql.database.azure.com',
    user            : 'saadmin@mysqljapanwestsmc',
    password        : '1qaz@wsx3edC',
    database        : 'sample_db',
    port: 3306,
    ssl  : {
        // DO NOT DO THIS
        // set up your ca correctly to trust the connection
        rejectUnauthorized: false
      }
});

pool.getConnection(function(err, connection) {
    if (err) throw err; // not connected!
  
    // Use the connection
    connection.query('SELECT 1', function (error, results, fields) {
      // When done with the connection, release it.
      connection.release();
  
      // Handle error after the release.
      if (error) throw error;
  
      // Don't use the connection here, it has been returned to the pool.
    });
});


  
