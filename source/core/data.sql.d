module tym.sql;
import data = tym.data;
import std.process;
import tym.implementation;
import vibe.d;
import vibe.data.json;

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

Json executeJSON(string sql, data.IColumn[] args = null) {
	string commandString;
	Settings s;
	switch (s.dbFlavour) {
		case data.DbFlavour.mysql:
		case data.DbFlavour.mssqlserver:
			// NotYetImplementedException
			data.FlavourCheck();
			break;
		default: //	use prepared statements to prevent injection
			string prepare;
			prepare ~= "PREPARE plan";
			if(args != null) {
				prepare ~= "(";
				for (int i = 0; i < args.length; i++) {
          prepare ~= args[i].Type().name(data.DbFlavour.postgres);
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
			commandString ~= command() ~ " -t";
			commandString ~= " " ~ connectionString();
			commandString ~= " -c " ~ "\"" ~ prepare ~ "\"";
      logInfo(commandString);
	}
	return parseJsonString(to!string(executeShell(commandString).output));
}
