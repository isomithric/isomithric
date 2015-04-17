var Server, builder, client, component, m, model, ref;

component = require("./isomithric/component");

model = require("./isomithric/model");

client = require("./isomithric/client");

if (typeof document === "undefined") {
  ref = require("./isomithric/server"), m = ref[0], Server = ref[1];
}

builder = function(m) {
  var iso;
  iso = component(m);
  iso.model = model(m);
  iso.Client = client(m);
  if (Server) {
    iso.Server = Server;
  }
  return iso;
};

module.exports = m ? function() {
  return builder(m);
} : builder;
