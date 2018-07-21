module tym.core.data.sql;
import tym.core.data.types;
import tym.settings;
import tym.core.data.pgsql;
import vibe.d;
import vibe.data.json;

/**
*	Handles the initial command based on the DbFlavour
*/
/*
string command(){
	string command;
	Settings s;
	switch (s.dbFlavour) {
		case data.DbFlavour.mysql:
		case data.DbFlavour.mssqlserver:
			// NotYetImplementedException
			data.FlavourCheck();
			break;
		default: //postgres
			command = "psql";
	}
	return command;
}
*/
/**
*	Generates the connection string parameters based on the DbFlavour
*/
/*
string connectionString() {
	string connectionString;
	Settings s;
	switch (s.dbFlavour) {
		case data.DbFlavour.mysql:
		case data.DbFlavour.mssqlserver:
			// NotYetImplementedException
			data.FlavourCheck();
			break;
		default: //	postgres://username:password@host/database
			connectionString ~= "postgres://";
			connectionString ~= s.username;
			connectionString ~= ":";
			connectionString ~= s.password;
			connectionString ~= "@" ~ s.host;
			connectionString ~= "/" ~ s.database;
	}
	return connectionString;
}
*/
/**
*	Executes SQL parameterising arguments returning it in JSON format
*/
Json executeJSON(string sql, IColumn[] args = null) {
	string commandString;
	Settings s;
	switch (s.dbFlavour) {
		case DbFlavour.mysql:
		case DbFlavour.mssqlserver:
			// NotYetImplementedException
			FlavourCheck();
			break;
		default: //	use prepared statements to prevent injection
			string prepare;
			prepare ~= "PREPARE plan";
			if(args != null) {
				prepare ~= "(";
				for (int i = 0; i < args.length; i++) {
					prepare ~= args[i].Type().name(DbFlavour.postgres);
					if(i < args.length -1) {
						prepare ~= ",";
					}
				}
				prepare ~= ")";
			}
			prepare ~= " AS ";
			prepare ~= "SELECT row_to_json(r) FROM (" ~ sql ~ ") r; EXECUTE plan";
			if(args != null) {
				prepare ~= "(";
				for (int i = 0; i < args.length; i++) {
					prepare ~= args[i].getValue();
					if(i < args.length -1) {
						prepare ~= ",";
					}
				}
				prepare ~= ")";
			}
			prepare ~= ";";

			PGConnection conn = new PGConnection();
			conn.open();
			conn.close();

			/*
			commandString ~= command() ~ " -t";
			commandString ~= " " ~ connectionString();
			commandString ~= " -c " ~ "\"" ~ prepare ~ "\"";
			*/
			logInfo(prepare);
	}
	//return parseJsonString(to!string(executeShell(commandString).output));
	return parseJsonString('{ "test" : "test" }');
}
