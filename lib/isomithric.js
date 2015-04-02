require("coffee-script/register");

module.exports = {
	Client:    require("./isomithric/client"),
	Component: require("./isomithric/component"),
	Model:     require("./isomithric/model"),
	Server:    require("./isomithric/server")
};
