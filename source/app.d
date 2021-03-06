import vibe.d;
import tym.api.text;
import tym.api.build;
import tym.settings;
import impl = tym.implementation;

shared static this()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];

	auto router = new URLRouter;
	router.registerRestInterface(new TextAPI);
	router.registerRestInterface(new BuildAPI);

	Settings s;
	foreach (path; s.staticPaths) {
		auto fsettings = new HTTPFileServerSettings;
		fsettings.serverPathPrefix = "/" ~ path;
		router.get("*", serveStaticFiles(path ~ "/", fsettings));
	}
	router.get("*", serveStaticFiles("public/"));

	// start implmenetation;
	impl.go();

	listenHTTP(settings, router);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}
