module.exports = function () {
  var index = require("./main");
  var users = require("./users");
  return { index, users };
};
