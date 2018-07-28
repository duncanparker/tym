module tym.settings;
import tym.core.data.types: DbFlavour;

/*
	The application settings.
	Contains your database connection settings.
*/
public final struct Settings {
	DbFlavour dbFlavour = DbFlavour.postgres;
	string host = "127.0.0.1";
	string port = "5432";
	string database = "tym";
	string username = "tymadmin";
	string password = "tymadmin";
}
