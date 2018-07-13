import vibe.d;
import text = tym.textAPI;
import build = tym.build;
import impl = tym.implementation;

shared static this()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];

	auto router = new URLRouter;
	router.registerRestInterface(new text.TextAPI);
	router.registerRestInterface(new build.BuildAPI);
	router.get("*", serveStaticFiles("public/"));

	// start implmenetation;
	impl.go();

	listenHTTP(settings, router);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}
