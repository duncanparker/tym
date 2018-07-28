module tym.core.data.pgsql;
import tym.core.data.types;
import tym.settings;
import ddb.postgres;
import vibe.data.json;
import vibe.d;
import std.conv;

public Json executeJSON(string sql, IColumn[] args = null){
	Settings s;
	auto conn = new PGConnection([
				"host" : s.host,
				"port" : s.port,
				"database" : s.database,
				"user" : s.username,
				"password" : s.password
	]);
	scope(exit) conn.close();
 	//	use prepared statements to prevent injection
	/*
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
	*/
	string jsonSelect = "SELECT row_to_json(r) FROM (" ~ sql ~ ") r;";
	/*
	prepare ~= jsonSelect ~ " EXECUTE plan";
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
	logInfo(prepare);
	*/
	auto cmd = new PGCommand(conn, jsonSelect);
	foreach (arg; args) {
		PGType type = typeCon(arg.Type().type());
		cmd.parameters.add(1, type).value = arg.getValue();
	}
	auto result = cmd.executeQuery;
	string json = "";
	foreach(row; result) {
			json ~= to!string(row[0]);
	}
	return parseJsonString(json);
}

// Until i implement my own TCP and types, this will have to do
PGType typeCon(DbType type) {
	switch(type) {
		case DbType.dbBool:
			return PGType.BOOLEAN;
		case DbType.dbBytes:
			return PGType.BYTEA;
		case DbType.dbChar:
			return PGType.TEXT;
		case DbType.dbDateTime:
			return PGType.TIMESTAMP;
		case DbType.dbDecimal:
			return PGType.FLOAT8; //damn :( will have to fork.
		case DbType.dbDouble:
			return PGType.FLOAT8;
		case DbType.dbFloat:
			return PGType.FLOAT4;
		case DbType.dbInt16:
			return PGType.INT2;
		case DbType.dbInt32:
			return PGType.INT4;
		case DbType.dbInt64:
			return PGType.INT8;
		case DbType.dbMoney:
			return PGType.FLOAT4;
		default:
			return PGType.TEXT;
	}
}
