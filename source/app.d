import vibe.d;

import text = tym.textAPI;

shared static this()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];

	auto router = new URLRouter;
	router.registerRestInterface(new text.TextAPI);
	router.get("*", serveStaticFiles("public/"));


	listenHTTP(settings, router);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}
