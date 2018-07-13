module tym.build;
import vibe.web.rest;
import vibe.d;
import data = tym.data;
import impl = tym.implementation;
import std.process;

@path("/build")
interface IBuildAPI {
	@path("testconnection")
	@method(HTTPMethod.GET)
	string testconnection();
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
	string testconnection(){
		string connectionstring;
		string command;
		string sql;
		string response;

		impl.Settings s;
		switch (s.dbFlavour) {
			case data.DbFlavour.mysql:
			case data.DbFlavour.mssqlserver:
				// NotYetImplementedException
				data.FlavourCheck();
				break;
			default: //postgres
				command = "psql";
				connectionstring ~= "postgres://";
				connectionstring ~= s.username;
				connectionstring ~= ":";
				connectionstring ~= s.password;
				connectionstring ~= "@" ~ s.host;
				connectionstring ~= "/" ~ s.database;
				sql ~= "-c \"SELECT 'Success' AS Test\"";
				command ~= " " ~ connectionstring ~ " " ~ sql;
				logInfo(command);
				break;
		}
		auto result = to!string(executeShell(command).output);
		logInfo("Running Test");
		logInfo(result);
		return result;
	}
}
