module tym.build;
import data = tym.data;
import db = tym.sql;
import vibe.web.rest;
import vibe.data.json;

@path("/build")
interface IBuildAPI {
	@path("testconnection")
	@method(HTTPMethod.GET)
	Json testconnection();

	@path("all")
	@method(HTTPMethod.GET) // Switch to post with security check when auth module implemented
	string buildAll();
}

/**
* The intention of this class is to provide an endpoint to build the database and any default
* data from the Tables in tym.implementation.BuildTargets[].
*/
class BuildAPI : IBuildAPI {
	/**
	*	Tests the database connection settings.
	* returns: {string} Response from the database.
	*/
	Json testconnection(){
		string sql = "SELECT 'Success' AS Test";
		data.Column success = new data.Column("Test", new data.DbChar(7));
		success.setValue("Success");
		return db.executeJSON(sql, [ success ]);
	}

	// Builds all of the BuildTargets from the implementation module on the database

	string buildAll() {
		// TODO: build the BuildTargets
		return ""; // TODO: return helpful success/failure
	}
}
