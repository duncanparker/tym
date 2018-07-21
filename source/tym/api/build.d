module tym.api.build;
import data = tym.core.data.types;
import db = tym.core.data.sql;
import vibe.web.rest;
import vibe.data.json;

/**
* The intention of this endpoint is to build the database and any default
* data from the Tables in tym.implementation.BuildTargets[].
*/
@path("/build")
interface IBuildAPI {
	/**
	*	Tests the database connection settings.
	* returns: {string} Response from the database.
	*/
	@path("testconnection")
	@method(HTTPMethod.GET)
	Json testconnection();

	/**
	*	Builds all of the BuildTargets from the implementation module on the database
	* TODO: Switch to HTTPMethod.POST with security check when auth module implemented
	*/
	@path("all")
	@method(HTTPMethod.GET) //
	string buildAll();
}

class BuildAPI : IBuildAPI {
	Json testconnection(){
		string sql = "SELECT 'Success' AS Test";
		data.Column success = new data.Column("Test", new data.DbChar(7));
		success.setValue("Success");
		return db.executeJSON(sql, [ success ]);
	}

	string buildAll() {
		// TODO: build the BuildTargets
		return ""; // TODO: return helpful success/failure
	}
}
