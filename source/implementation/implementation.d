module tym.implementation;
import tym.data;

/*
  ====================================================
                  Module Import
  ====================================================
  Import your modules here containing the ITables that
  you want to build into your database.
*/
import motd = tym.motd;


/*
  Add to this array the ITables you want to build from your modules above.
*/
public ITable[] BuildTargets = [
  new motd.MOTD()
];

/*
  The application settings.
  Contains your database connection settings.
*/
public final struct Settings {
  DbFlavour dbFlavour = DbFlavour.postgres;
  string host = "127.0.0.1";
  string database = "tym";
  string username = "tymadmin";
  string password = "tymadmin";
}


// This is could your entry point for your business logic
public void go() {
  // custom stuff here
}
