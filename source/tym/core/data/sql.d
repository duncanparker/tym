module tym.core.data.sql;
import tym.core.data.types;
import tym.settings;
import psql = tym.core.data.pgsql;
import vibe.d;
import vibe.data.json;

/**
*	Executes SQL parameterising arguments returning it in JSON format
*/
Json executeJSON(string sql, IColumn[] args = null) {
	Settings s;
	switch (s.dbFlavour) {
		case DbFlavour.mysql:
		case DbFlavour.mssqlserver:
			// NotYetImplementedException
			FlavourCheck();
			break;
		default:
			return psql.executeJSON(sql, args);
	}
	//return parseJsonString(to!string(executeShell(commandString).output));
	return parseJsonString("{ \"test\" : \"fail\" }");
}
