module tym.build;
import vibe.web.rest;
import tym.data;

@path("/build")
interface IBuildAPI {
	@path("all")
	@method(HTTPMethod.PUT)
	void buildAll();
}

class BuildAPI : IBuildAPI {
	void buildAll(){

	}
}
